---
layout: page
title: Process Tracking
has_toc: false
nav_order: 3
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

{%- assign projects_by_date = site.data.project_array | sort: "retirement_date" | reverse %}
{%- assign list_date_fmt = "%b %Y" %}

# The Apache Attic Process Tracking
***

This page lists projects in *Retirement Date* order and shows the *Completion Date* of the project's
move to the Attic along with the [Attic JIRA](https://issues.apache.org/jira/projects/ATTIC) ticket
used to track the move.
{: .fs-5}

### Useful links:

  - [Board Minutes Calendar](https://www.apache.org/foundation/board/calendar.html) to find "Terminate" resolutions
  - [Projects Directory](https://projects.apache.org/) to check
  - [Open Jira issues](https://issues.apache.org/jira/issues/?jql=status%20in%20(Open%2C%20%22In%20Progress%22%2C%20Reopened)%20AND%20labels%20%3D%20retire-project)
  - [Retirement Process Documentation]({% link process.md %})

|Retirement Month|Completed|Project|Tracking|
|:-------------|:-------------|:-------------|:-------------|
{%- for project in projects_by_date -%}
{%- assign retire_date = project.retirement_date  | date: list_date_fmt -%}
{%- assign attic_date = project.attic_date | date: list_date_fmt -%}
{% assign proj_link = project.project_id | prepend: "projects/" | append: ".html" %}
|{{ retire_date }}|{{ attic_date }}|[{{ project.project_apachename }}]({%- link {{proj_link}} -%})|[{{ project.attic_issue }}]({{ project.attic_issue_link }})|
{%- endfor -%}

