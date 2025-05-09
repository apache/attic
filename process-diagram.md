---
layout: page
title: Diagram
has_toc: false
parent: Process
nav_order: 10
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

# Attic Process Diagram
***
The diagram below shows the main steps to move a *Retired Project* to the Attic
(click for a description of each step of the process).

```mermaid
graph TD;
    accTitle: the Attic Process
    accDescr: Attic process diagram which shows the steps of moving a Retired Project to the Attic
    RESL("`1 **Confirm Board Resolution**`")
    JIRA("`**Create Attic JIRA**
        (to manage the move)`")
    PROJ("`2 **Create Project Page**
        on Attic Site`")
    USER("`3 **Inform Users**
        of move to Attic`")
    DOAP("`4 **Update Project DOAP**
        file (if any)`")
    LOCK("`5 **Lock Down Resources**
        (create Infra JIRA ticket)`")
    ANNC("`6 **Announce**
        *announce AT apache.org*`")
    RESL-->JIRA;
    RESL-->PROJ;
    JIRA<-->PROJ;
    PROJ-->USER;
    PROJ-->DOAP;
    PROJ-->LOCK;
    USER-->ANNC;
    DOAP-->ANNC;
    LOCK-->ANNC;
    click RESL "/process-howto.html#1-confirm-board-resolution"
    click PROJ "/process-howto.html#2-create-project-page-on-attic-site"
    click USER "/process-howto.html#3-inform-users-of-the-move-to-the-attic"
    click DOAP "/process-howto.html#4-update-the-project-doap-file-if-any"
    click LOCK "/process-howto.html#5-get-infra-to-lock-down-project-resources"
    click ANNC "/process-howto.html#6-announce-on-announce-at-apacheorg"
```
