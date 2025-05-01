<!--
#
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
-->

# Apache Attic Website

This is the source code for the website at [attic.apache.org](https://attic.apache.org)
which manages ASF projects which have retired.

This site uses [Jekyll](https://github.com/jekyll/jekyll), which is a static site generator,
with the [Just The Docs](https://just-the-docs.github.io/just-the-docs/) Theme. See:
 - [The Jekyll Docs](https://jekyllrb.com/docs/) on how to install Jekyll and build this
site locally.
 - [Just The Docs](https://just-the-docs.github.io/just-the-docs/) on configuring the theme

## Overview

The [Attic Website](https://attic.apache.org) is composed of the following:

  - Simple `markdown` pages such as the _home_ (`index.md`) and _Process_ (`process.md`) pages.
  - A `yaml` file for each project in the `_data/projects` directory which contains all the
    details about the project and its retirement
  - The _Process Tracking_ (`tracking.md`) page which generates a table showing the status of each
    project generated from the files in `_data/projects' directory.
  - [Jekyll Plugins](https://jekyllrb.com/docs/plugins/) which generate pages and files for the
    retired projects from the files in `_data/projects' directory:
    - `_plugins/projects-plugin.rb` generates the [project pages](https://attic.apache.org/projects/)
      from the project's `yaml` data file.
    - `_plugins/attic-banner-plugin.rb` generates a _flag_ file to indicate that the _Attic Banner_
      should be added to a project's website (based on the project's `yaml` data file).
    - `_plugins/cwiki-banner-plugin.rb` generates a _flag_ file to indicate that the _Attic Banner_
      should be added to the project's CWIKI spaces (based on the project's `yaml` data file).

## Project YAML Data File

The project YAML files contain the following information in order to generate the project pages:
  - **Retirement Date** (usually the date of the board meeting the project was terminated)
  - **JIRA ID** of the ticket used to track the project's move to the Attic
  - **Completion Date** of the project's move to the Attic
  - **Project Description**
  - **Source Code** repositorie(s)
  - **Mailing Lists**
  - **Issue Tracker(s)**
  - **Wiki** space(s)
  - **Download Details**
  - **Related Projects**

Creating/Updating a project's YAML file updates the project page, updates the Tracking page
and generates any required flags for the project's website and wiki.

The structure of the project YAML file is shown below:

```yaml
retirement_date: yyyy-mm-dd      ### [REQUIRED] Date the project retired (date of board meeting)
attic_issue: ATTIC-XXX           ### [OPTIONAL] The JIRA-ID managing the projects retirement
attic_date: yyyy-mm-dd           ### [OPTIONAL] Date the move to the Attic was completed
attic_banner: true               ### [OPTIONAL] Valid values: true/false (should banner be generated, normally true)
revived_date: yyyy-mm-dd         ### [OPTIONAL] Date the project was revived - moved out of the Attic
project_name: [Another Name]     ### [OPTIONAL] defaults to this file name
project_longname:                ### [OPTIONAL] defaults to this file name
project_domain: [alt domain]     ### [OPTIONAL] defaults to this file name + ".apache.org"
project_description: >-          ### [REQUIRED]
    [Project description here]   ### Note that some characters - e.g. ':' - require the text to be enclosed in ''
    [further description line]   ### text can be continued on the next line, keeping the same indentation
additional_text: >-              ### [OPTIONAL]
    [Put some text here]         ### Note that some characters - e.g. ':' - require the text to be enclosed in ''
board_resolution: true           ### [REQUIRED] Valid values: true/false (link to board minutes from retirement date?)
board_reports: true              ### [REQUIRED] Valid values: true/false (include Board Reports section?)
downloads: true                  ### [REQUIRED] Valid values: true/false (include Downloads section?)
archive_path:                    ### [OPTIONAL] Defaults to this file name
source_repositories:
    - type: Git                  ### [REQUIRED] Valid Values: Subversion, Git (may have both)
      path: [some/path]          ### [OPTIONAL] Defaults to this file name
mailing_lists:                   ### [REQUIRED] public mailing list names
    - dev
    - commits
    - user
mailing_lists_prefix:            ### [OPTIONAL] Defaults to this file name
issue_trackers:
    - type: JIRA                 ### [REQUIRED] Valid Values: JIRA, Bugzilla
      keys:
        - JIRA_KEY_1             ### [OPTIONAL] Defaults to this file name
wiki:                            ### [OPTIONAL] Not all projects have a Wiki
    type: CWIKI                  ### [REQUIRED] Valid values: CWIKI
    keys:
      - WIKI_KEY_1               ### [OPTIONAL] Defaults to this file name
related_projects_text: >-
    [Put some description here]  ### [OPTIONAL]
related_projects:
    - name:                      ### [OPTIONAL]
      url:                       ### [OPTIONAL]
      description:               ### [REQUIRED]

```

Heres an example of a file for **Any23**:

```yaml
retirement_date: 2023-06-21
attic_issue: ATTIC-215
attic_date: 2023-10-01
attic_banner: true 
project_description: >-
    The mission of Apache Any23 (Anything to Triples) was the creation and
    maintenance of software related to automatic crawling, parsing, analyzing,
    producing, validating and converting RDF (Resource Description Framework) data.
board_resolution: true
board_reports: true
downloads: true
source_repositories:
    - type: Git
mailing_lists:
    - dev
    - commits
    - user
issue_trackers:
    - type: JIRA
wiki:
    type: CWIKI

```

## How to test locally (DRAFT) ##

Install Ruby.
Install bundler if necessary: ```gem install bundler```

If you wish to install the required Gems locally (rather than updating the system Gems),
change the bundler installation directory:

```bundle config path 'vendor/bundle' --local```

Now install the required gems:

```bundle install```

To build the site:

```bundle exec jekyll build```

To build the site and make it available at http://localhost:4000/

```bundle exec jekyll server```

To run retire.rb:

```bundle exec ruby retire.rb projectId ...```
