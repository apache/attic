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
# Generates the Retired Project pages.
#
# Process each yaml file in the "_data/projects" folder and generates
# a page per project using the project's yaml file and the 
# "_layouts/project-layout.html" template.
#
module ProjectsPlugin
  class CategoryPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      site.data['project_array'].each_with_index do | project, index |
        site.pages << ProjectPage.new(site, index, project)
      end
    end
  end

#
# Generate a page for a project.
#
# Subclass of `Jekyll::Page` with custom method definitions.
  class ProjectPage < Jekyll::Page
    def initialize(site, index, project)

      @site = site                  # the current site instance.
      @base = site.source           # path to the source directory.
      @dir  = 'projects'            # the directory the page will reside in.

      # Page name
      @basename = project['project_id'] # filename without the extension.
      @ext      = '.html'               # the extension.
      @name     = @basename + @ext      # filename
      
      # Look up front matter defaults scoped to type `categories`, if given key
      # doesn't exist in the `data` hash.
      #data.default_proc = proc do |_, projname|
      #  site.frontmatter_defaults.find(relative_path, :projects, projname)

      # Define custom data.
      @data = project.clone
      @data['layout'] ='project-layout'
      @data['title'] = project['project_name']
      @data['parent'] = 'Retired Projects'
      @data['nav_order'] = index
      @data['has_toc'] = true
    end
  end
end