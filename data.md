---
layout: page
title: Data Reference (YAML)
parent: Process
nav_order: 3
nav_exclude: false
---
{%- comment -%}
Licensed to the Apache Software Foundation (ASF) under one or more
contributor license agreements.  See the NOTICE file distributed with
this work for additional information regarding copyright ownership.
The ASF licenses this file to you under the Apache License, Version 2.0
(the "License"); you may not use this file except in compliance with
the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
{% endcomment %}

# Data Reference (YAML)
***

Much of the content on this website is generated from
[project data files]({{site.repo}}/blob/main/_data/projects/) in
[YAML Format](https://en.wikipedia.org/wiki/YAML). This page describes
how the data files are used and the contents of the files:
  - [How the Data Files are Used](#how-the-data-files-are-used)
  - [Data File Attributes (YAML)](#data-file-attributes-yaml)
  - [Example YAML File](#example-yaml-file)
  - [YAML Template File](#yaml-template-file)

## How the Data Files are Used

The project YAML files are used to generate the following:

 - **Project Pages**
   - A [Project Page]({% link projects.md %}) is generated for each *retired project* which has details
     about the project, it's retirement and its resources, such as *Source Repositories*, *Mailing Lists*,
     *Downloads* and *Wikis*
 - **Template Pages**
   - Projects which are ***[In Process]({% link tracking.md %})*** of being retired
     (i.e. those that don't have an `attic_date`) have a generated 
     ***template page***. The page contains templates for the following:
     - Creating an **Attic JIRA** ticket to manage the project's retirement
     - Creating an **Infrastructure JIRA** ticket to get the Infrastructure team
       to lock down the project's resources
     - An **Email to Inform Users** about the project's retirement
     - An **Email to Announce** the project's retirement
 - **Project Lists**
    - The files are used to generate lists of projects on pages such as the
      [Tracking Process]({% link tracking.md %}), the [Projects Page]({% link projects.md %})
      and the Navigation links on the left.
 - **Site Banners**
    - Setting the `attic_banner=true` attribute causes the ***"This project has
      retired"*** banner to be displayed on all the pages of the project's website.
      It does this by generating a file in the
      ***[flagged](https://github.com/niallkp/attic-justthedocs/tree/asf-site/flagged)*** directory.
 - **CWIKI Banners**
    - Adding a `wiki` configuration with `type=CWIKI` causes the ***"This project has retired"*** banner to
      be displayed on all pages of the project's CWIKI spaces. It does this by generating a file in
      the ***[cwiki_retired](https://github.com/niallkp/attic-justthedocs/tree/cwiki-retired)*** directory.
  
  
## Data File Attributes (YAML)

|Attribute|Required?|Format/Values|Description|Examples|
|:--------|:--------|:------------|:----------|:-------|
|project_id|**GENERATED**| - |Generated from the YAML file name, without the `.yaml` suffix ||
|retirement_date|Required|yyyy-mm-dd|Date the project retired (date of board meeting)||
|attic_issue|Optional|ATTIC-nnn|The [Attic JIRA](https://issues.apache.org/jira/projects/ATTIC/) ID managing the projects retirement||
|attic_date|Optional|yyyy-mm-dd|Date the move to the Attic was completed||
|attic_banner|Optional|true/false|Cause the ***Attic Banner*** to be displayed on the project's website (normally true)||
|project_type|Optional|PMC, Subproject|Defaults to ***PMC*** (Historically Attic took in sub-projects, which is no longer the case)||
|project_name|Optional|text|defaults to the `${project_id}` (capitialized)|**ODE**:
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/ode.yaml)/[Page]({% link projects/ode.html %})|
|project_longname|Optional|text| defaults to the `${project_name}`|**ODE**:
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/ode.yaml)/[Page]({% link projects/ode.html %})|
|project_domain|Optional|domain name|defaults to `${project_id}.apache.org`|**Quetzalcoatl**: 
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/quetzalcoatl.yaml)/[Page]({% link projects/quetzalcoatl.html %})|
|project_description|Required|text|Description of the project||
|project_shortdesc|Optional|text|defaults either to the `description` in the `retired_projects.json`
    {%- out %} file or the first sentence of the `${project_description}`||
|additional_text|Optional|text|Additional Text displayed on the project page below the project description|**Avalon**: 
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/avalon.yaml)/[Page]({% link projects/avalon.html %})|
|board_resolution|Required|true/false|If true, used to link to board minutes in combination with the `${retirement_date}`||
|board_reports|Required|true/false|Cause a link to the project's Board Reports be shown on the project's page||
|downloads|Required|true/false|Cause a link to the archive donwload's page for the project to be shown on the project page||
|archive_path|Optional|path|Path to the project's download area. Defaults to the `${project_id}`|**Joshua**:
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/joshua.yaml)/[Page]({% link projects/joshua.html %})|
|source_repositories|Optional|Array|An array of the project's source respositories||
|source_repositories: type|Required|Git, Subversion|Type of Source Respository|**Git(Any23)**:
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/any23.yaml)/[Page]({% link projects/any23.html %})|
|source_repositories: path|Optional|path|Alternative respoitory path. Defaults to `${project_id}`|**Subversion(OJB)**:
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/ojb.yaml)/[Page]({% link projects/ojb.html %})|
|mailing_lists|Optional|Array|List of the project's public mailing lists (e.g. dev, user etc)||
|mailing_lists_prefix|Optional| |mbox_prefix if required (usually for Subprojects)|**Xang**: 
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/xang.yaml)/[Page]({% link projects/xang.html %})|
|issue_trackers|Optional|Array of Map|Details of the project's Issue tracker(s)|**ORO (Bugzilla)**: 
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/jakarta-oro.yaml)/[Page]({% link projects/jakarta-oro.html %})|
|issue_trackers: type|Required|JIRA, GitHub, Bugzilla|Type of Issue Tracker|**Aurora (GitHub,JIRA)**:
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/aurora.yaml)}/[Page]({% link projects/aurora.html %})|
|issue_trackers: keys|Optional|Array|List of Issue Tracker Key(s). Defaults to `${project_id}`|**Apex (JIRA)**:
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/apex.yaml)/[Page]({% link projects/apex.html %})|
|wiki|Optional|Map|Details of the project's Issue tracker(s)||
|wiki: type|Required|CWIKI|Type of Wiki. CWIKI causes the ***Attic Banner*** to be displayed on the CWIKI spaces||
|wiki: keys|Optional|Array|List of Wiki Key(s). Defaults to `${project_id}`|**Eagle**:
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/eagle.yaml)/[Page]({% link projects/eagle.html %})|
|related_projects_text|Optional|text|Text displayed before the list of related projects (if any) on the project's page|**iBATIS**:
    {%- out %} [YAML]({{site.repo}}/blob/main/_data/projects/ibatis.yaml)/[Page]({% link projects/ibatis.html %})|
|related_projects|Optional|Array of Maps|Details of Related Projects, shown at the bottom of the project page (if any)|**Hivemind**:
    {%- out %}[YAML]({{site.repo}}/blob/main/_data/projects/hivemind.yaml)/[Page]({% link projects/hivemind.html %})|
|related_projects: name|Optional|text|Name of the related project||
|related_projects: url|Optional|url|URL of the related project||
|related_projects: description|Required|text|Description of the related project||


## Example YAML File
Below is an example, of a [YAML file for Any23]({{site.repo}}/blob/main/_data/projects/any23.yaml)
which generates the [Any23 Project Page]({% link projects/any23.html %}).

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


## YAML Template File
The following is a standard starter template for a YAML file:

```yaml
retirement_date: yyyy-mm-dd
attic_issue: ATTIC-nnn
attic_date:
attic_banner: true 
project_description: >-
    [put the project description here]
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
