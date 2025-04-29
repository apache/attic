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
# Generates the files to "Flag" projects that should have the "Attic Banner"
# add to their projects website.
#
# Process each yaml file in the "_data/projects" folder and creates a file
# in "flagged/sites" for each project which has 'attic_banner=true'.
#
# This file is used by a "lua" filter to decide whether to add the "Retired Banner"
# to the project's website.
#
module AtticBannerPlugin
  class CategoryPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      site.data['project_array'].each do | project |
        if project['attic_banner'] == true
          site.pages << AtticBannerPage.new(site, project['project_id'], project['project_domain'])
        end
      end
    end
  end

#
# Create the file for the project in the 'flagged/site' directory.
#
# Subclass of `Jekyll::Page` with custom method definitions.
  class AtticBannerPage < Jekyll::Page
    def initialize(site, projectId, project_domain)

      @site = site                   # the current site instance.
      @base = site.source            # path to the source directory.
      @dir  = 'flagged/' + projectId # the directory the page will reside in.

      # Page name
      @basename = 'git'              # filename without the extension.
      @ext      = '.keep'            # the extension.
      @name     = @basename + @ext   # filename

      # Define custom data.
      @data = {
          'layout' => 'attic-banner-layout',
          'project_id' => projectId,
          'project_domain' => project_domain
      }
    end
  end
end