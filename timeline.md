---
layout: page
title: Timeline
parent: The Apache Attic
has_toc: false
nav_order: 30
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

# Project Retirements Timeline
***

The following timeline shows Projects retiring for each year (including Sub-Projects, if any).

{% assign no_of_years = 20 -%}
{% assign sorted_years = site.data.years_array |  sort: 'year' -%}
{% assign first = sorted_years | size | minus: no_of_years | at_least: 0 -%}


```mermaid
timeline
    title History of Project Retirements  
  {% for year in sorted_years offset: first %}
    {{ year['year'] }}
    {%- assign sorted_projects = year['projects']  | sort: 'retirement_date' -%}
    {%- for project in sorted_projects -%}
      {{ project['project_name'] | prepend: ' : '}}
    {%- endfor -%}
  {% endfor %}
```


{: .note}
This is currently configured to show the last **{{ no_of_years}} years** of retirements (easily changed through the `no_of_years` variable).
