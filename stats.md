---
layout: page
title: Statistics
parent: The Apache Attic
has_toc: false
nav_order: 20
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

# Project Retirements Stats
***

The following graph shows the number of Projects retiring for each year (**NOT** including **Sub-Projects**).

{% assign sorted_years = site.data.years_array |  sort: 'year' -%}
{% assign no_of_years = 20 -%}
{% assign first = sorted_years | size | minus: no_of_years | at_least: 0 -%}
{% assign p_counts = sorted_years | map: "p_count" %}
{% assign count_max = 0 -%}
{%- for year in sorted_years offset: first -%}
    {% assign count_max = count_max | at_least: year['p_count'] -%}
{%- endfor %}

```mermaid
xychart-beta
    title "Project Retirements by Year"
    x-axis "Year" [{{ sorted_years | map: "year" | join: ', ' }}]
    y-axis "Number of Projects" 0 --> {{count_max | plus: 2 | at_least: 10}}
    bar [{{ p_counts | join: ', ' }}]
    line [{{ p_counts | join: ', ' }}]
```

{: .note}
This is currently configured to show the last **{{ no_of_years}} years** of retirements (easily changed through the `no_of_years` variable).

