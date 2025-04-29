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
# Generates a page of templates for use in the project's move to the Attic.
#
module ProjectTemplatesPlugin
  class CategoryPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      site.data['project_array'].each do | project |
        if project['attic_date'].nil?
          site.pages << ProjectTemplatesPage.new(site, project['project_id'], project)
        end
      end
    end
  end

#
# Create the file for the project in the 'templates' directory.
#
# Subclass of `Jekyll::Page` with custom method definitions.
  class ProjectTemplatesPage < Jekyll::Page
    def initialize(site, projectId, project)

      @site = site                   # the current site instance.
      @base = site.source            # path to the source directory.
      @dir  = 'templates'            # the directory the page will reside in.

      # Page name
      @basename = projectId          # filename without the extension.
      @ext      = '.html'            # the extension.
      @name     = @basename + @ext   # filename

      # Define custom data.
      @data = project.clone
      @data['layout'] ='project-templates-layout'
      @data['title'] = project['project_name'] + ' Templates'
      @data['parent'] = 'Process Tracking'
      @data['nav_exclude'] = false   # Show link under project page

    end
  end
end