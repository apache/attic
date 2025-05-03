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

Data for retired projects is stored in YAML, which are described on the Attic
[Data Reference (YAML)](https://attic.apache.org/data.html) page.

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

To build the site and make it available at http://127.0.0.1:4000/

```bundle exec jekyll server```

To run retire.rb:

```bundle exec ruby retire.rb projectId ...```
