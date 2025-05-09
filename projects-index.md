---
layout: page
title: Index
parent: The Apache Attic
nav_exclude: false
nav_order: 10
has_toc: false
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

## [Retired Projects]({% link projects.md %})

{% assign project_array = site.data.project_array |  where: "project_type", "PMC" -%}
{%- for project in project_array -%}
[{{project.project_name}}]({%- link {{project.project_id | prepend: "projects/" | append: ".html"}} %} "{{project.project_shortdesc}}"){: .btn style="font-family:SFMono-Regular;" }&nbsp;
{% endfor -%}

## Retired Sub-Projects

{% assign subproject_array = site.data.project_array |  where: "project_type", "Subproject" -%}
{%- for project in subproject_array -%}
[{{project.project_name}}]({%- link {{project.project_id | prepend: "projects/" | append: ".html"}} %} "{{project.project_shortdesc}}"){: .btn style="font-family:SFMono-Regular;" }&nbsp;
{% endfor %}

{: .important}
Historically the Apache Attic accepted *Sub-Projects*, but this is no longer the case.
