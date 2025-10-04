# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#--------------------------------------------------------
#
# Process each project, adding in the following attributes:
#   - project_id
#   - project_name     (if not specifically set)
#   - project_longname (if not specifically set)
#   - project_domain   (if not specifically set)
#
# This plugin is set to "highest" priority so that it runs before any other
# plugins and the projects array is therefore available to them.
#

require 'json'

module ProjectDataPlugin
  class ProjectDataGenerator < Jekyll::Generator
    
    priority :highest
    
    def generate(site)
      
      Jekyll.logger.info "ProjectDataPlugin: Starting processing project data"

      projects = Array.new
      
      # the projects hash is created by Jekyll from the _data/projects directory contents
      site.data['projects'].each do | projectId, project|
        project['project_id'] = projectId
        project['project_name'] =  project.fetch("project_name", projectId.capitalize())
        project['project_name_lower'] =  project["project_name"].downcase
        project['project_longname'] = project.fetch("project_longname", project['project_name'] )
        project['project_apachename'] = "Apache " + project["project_longname"]
        project['project_domain'] =  project.fetch("project_domain", projectId + ".apache.org")
        if project['attic_issue']
          project['attic_issue_link'] =  "https://issues.apache.org/jira/browse/" + project['attic_issue']
        end
        if project['project_shortdesc'].nil?
          shortdesc = project['project_description']
          idx = shortdesc.index('.')
          if idx and idx > 0
            shortdesc = shortdesc.slice(0, idx + 1)
          end
          retired_proj = site.data['committee-retired']['retired'][projectId]
          if retired_proj
            shortdesc = retired_proj['description']
          end
          project['project_shortdesc'] =  shortdesc
        end
        if project['project_type'].nil?
          project['project_type'] = 'PMC'
        end
        # each repo type currently has at most one path
        project['source_repositories']&.each do |repo|
          if %w{Subversion Git}.include? repo['type']
            unless repo.include? 'path'
              repo['path'] = projectId
            end
          else
            puts "Unexpected repo #{repo}"
          end
        end
        # each tracker can include multiple keys
        project['issue_trackers']&.each do |tracker|
          if tracker['type'] == 'JIRA'
            unless tracker.include? 'keys'
              tracker['keys'] = [projectId.upcase]
            end
          elsif tracker['type'] == 'GitHub'
            unless tracker.include? 'keys'
              tracker['keys'] = [projectId]
            end
          elsif tracker['type'] == 'Bugzilla'
            unless tracker.include? 'keys'
              raise Exception.new "Bugzilla key must be provided"
            end
          else
            puts "Unexpected tracker #{tracker}"
          end
        end
        # There can only be one wiki but it can have multiple keys        
        wiki = project.fetch('wiki', nil)
        if wiki and wiki['type'] == 'CWIKI'
          unless wiki.include? 'keys'
            wiki['keys'] = [projectId.upcase]
          end
        end
        projects.push(project)
      end

      FileUtils.mkdir_p(site.dest) # might not exist yet
      File.write(File.join(site.dest, 'projects.json'), JSON.pretty_generate(site.data['projects'].sort.to_h))

      site.data['project_array'] = projects.sort_by { |project| project['project_name_lower'] }

      ## Initialize Array of years from 2009 onwards
      current_year = Time.new.year
      years = Array.new
      years.push({'year' => '2004'})
      for i in 2009..current_year do
        years.push({'year' => i.to_s})
      end
      
      ## Populate the projects in the Array
      projects = site.data['project_array'].sort_by { |project| project['retirement_date']}.reverse
      projects.each do | project|
        i = project['retirement_date'].year - 2008
        if i < 0
          i = 0
        end
        if years[i]['projects'].nil?
          years[i]['projects'] = Array.new
          years[i]['p_count'] = 0
          years[i]['s_count'] = 0
        end
        if project['project_type'] == 'Subproject'
          years[i]['s_count'] = years[i]['s_count'] + 1
        else
          years[i]['p_count'] = years[i]['p_count'] + 1
        end
        years[i]['projects'].push(project)
      end
      site.data['years_array'] = years.sort_by { |year| year['year'] }.reverse
      Jekyll.logger.info "ProjectDataPlugin: Processed " + projects.size.to_s + " projects in " + years.size.to_s + " years"
    end
  end
end