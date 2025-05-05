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
The Attic team will open an [Attic JIRA](https://issues.apache.org/jira/browse/ATTIC) item - `Move ${project} to the Attic`.

Issue content typically contains the following steps (click for a description of each step of the process):
   1. [Confirm Board Resolution](process-howto.html#1-confirm-board-resolution)
   1. [Create project page on Attic site](process-howto.html#2-create-project-page-on-attic-site)
   1. [Inform users of the move to the Attic](process-howto.html#3-inform-users-of-the-move-to-the-attic)
   1. [Update the project DOAP files (if any)](process-howto.html#4-update-the-project-doap-file-if-any)
   1. [Get Infra to lock down project resources](process-howto.html#5-get-infra-to-lock-down-project-resources)
   1. [Announce on *announce AT apache.org*](process-howto.html#6-announce-on-announce-at-apacheorg)

Getting help from terminating project is welcome, particularly
on informing users step or any other useful action at project's level like modifying DOAP file.
Don't hesitate to discuss through the Jira issue.
