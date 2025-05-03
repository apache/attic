---
layout: page
title: Process
has_toc: false
nav_order: 2
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

# Moving a PMC to the Attic
***

At some point a PMC may want to join the Attic.

The following defines a process
to move that PMC into the Attic and gently close it down.

## 1. A PMC decides to move to the Attic
  - Conduct a discussion on the public developer list whether to dissolve the PMC. Do not conduct
    it on the private PMC list.
  - Consider an appeal to the user list for interested users to provide their interest in helping out more.
  - Consider whether any contributors might be candidates for promotion to committers or PMC members.
  - Conduct a PMC vote on the public dev list.
  - If the PMC votes to dissolve the PMC and move to the Attic, inform the board of the successful vote on
     board@ mailing list (linking or forwarding the 'successful' vote) and add [a resolution](resolution.html) to dissolve the
     PMC to the next board meeting agenda.
  - If the PMC can't get enough people to vote to dissolve the PMC (and there are not three -1 votes), then
    that is grounds for moving to the Attic. They should inform the board as above, noting that the vote
    failed to get enough votes.

## 2. If the board approves the resolution
The Attic team will open an [Attic JIRA](https://issues.apache.org/jira/browse/ATTIC) item - 'Move ${project} to the Attic'.

Generated issue content typically contains following steps (see ["How to"](process-howto.html) for a description
of each step that the Attic team will follow):
   - \# Confirm Board Resolution
   - \# Create project page on Attic site: https://attic.apache.org/projects/$project.html
   - \# Inform users of the move to the Attic
   - \# Update the project DOAP files (if any) or copy to [projects-override](https://svn.apache.org/repos/asf/comdev/projects.apache.org/trunk/data/projects-override/)
   - \# Get infra lock down project's resources
   - \# Announce on [announce at apache.org](https://lists.apache.org/list?announce@apache.org:lte=1M:%22is%20now%20retired%22)

The Attic team will then execute the steps: getting help from terminating project is welcome, particularly
on informing users step or any other useful action at project's level like modifying DOAP.
