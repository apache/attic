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
# Generates the files to "Flag" CWIKI sites that should have the
# "Attic Banner" added.
#
# Process each yaml file in the "_data/projects" folder and creates files
# in "flagged/cwiki" for each project which has 'wiki.type = "CWIKI"' and
# all their CWIKI spaces.
#
# This file is used by a "lua" filter to decide whether to add the "Retired Banner"
# to the CWIKI's spaces.
#
module CwikBanngerPlugin
  class CategoryPageGenerator < Jekyll::Generator
    safe true

    def generate(site)
      site.data['project_array'].each do | project |
        if project['wiki'] and project['wiki']['type'] == 'CWIKI'
          if project['wiki']['keys'] 
            project['wiki']['keys'] .each do | key |
              site.pages << CwikiBannerPage.new(site, project['project_id'], key)
            end
          else
            site.pages << CwikiBannerPage.new(site, project['project_id'], project['project_id'])
          end
        end
      end
    end
  end

#
# Create the file for a CWIKI key for a project in the 'flagged/cwiki' directory.
#
# Subclass of `Jekyll::Page` with custom method definitions.
  class CwikiBannerPage < Jekyll::Page
    def initialize(site, projectId, cwiki_key)

      @site = site                   # the current site instance.
      @base = site.source            # path to the source directory.
      @dir  = 'cwiki_retired'        # the directory the page will reside in.

      # Page name
      @basename = cwiki_key.downcase # filename without the extension.
      @ext      = '.txt'             # the extension.
      @name     = @basename + @ext   # filename

      # Define custom data.
      @data = {
          'layout' => 'cwiki-retired-layout',
          'project_id' => projectId,
          'cwiki_key' => cwiki_key
      }
    end
  end
end