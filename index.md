---
layout: home
title: The Apache Attic
nav_order: 1
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

# The Apache Attic
***

The Apache Attic was created in
[November 2008](https://www.apache.org/foundation/records/minutes/2008/board_minutes_2008_11_19.txt)
to provide process and solutions to make it clear when an Apache project has reached its
end of life. Specifically, the Apache Attic Project:


```
[...] is responsible for the oversight of projects which otherwise would not have oversight;
[...] is not authorized to actively develop and release the projects under its oversight
```

It is intended to:
  - Be non-impacting to users
  - Provide restricted oversight for these codebases
  - Provide oversight for active user lists with no Project Management Committee (PMC)
  
It is not intended to:
  - Rebuild community
  - Make bugfixes
  - Make releases

### Getting into the Attic
There are two expected mechanisms by which a project may enter the Attic. Either the managing
Project Management Committee (PMC) decides it would like to move the project, or The
Apache Software Foundation's board dissolves the PMC and chooses to move the project.

First step is to add a suitable resolution to the next board agenda: see the
[Template Board Resolution]({% link resolution.md %}).

Once the submitted resolution has been approved during a board meeting, the Attic project starts
executing the move.

### When should a project move to the Attic?
Projects whose PMC are unable to muster 3 votes for a release, who have no active committers or
are unable to fulfill their reporting duties to the board are all good candidates for the Attic.

### Process of moving into the Attic
This is defined in greater details in the separate [process]({% link process.md %}) document.

### Process of leaving the Attic again

Options are:
  - Forking the project outside the Apache Software Foundation - we'll link to any forks which
    have been created so please let us know
  - Restarting the project at the Apache Software Foundation, with multiple ways to do so:
    - Restarting the community in the Apache Incubator
    - Recreating a PMC for the project
    - Transfering to an existing PMC

A receiving PMC must be willing to assume all responsibilities that come
with running a project: maintain code, answer questions, fix bugs,
publish releases etc.\
If the Board does not object, PMC Attic will transfer the project's
assets (code-base, TLP website, maven group-id etc) to the receiving PMC.\
After the transfer the receiving PMC will report to the Board about the
project's activities, and publish project releases in the PMC's dist area.

### Contacting the Attic Project

The Attic is a project as any other:

  - It is managed by a [Project Management Committee (PMC)](https://projects.apache.org/committee.html?attic).
  - Public discussions happen on a mailing list: see
     [general@attic.apache.org archive](https://lists.apache.org/list.html?general@attic.apache.org).
    You are welcome to subscribe and engage in discussion.
    
### Retired Incubator Projects
The [Apache Incubator](https://incubator.apache.org/) project is the entry path into
The Apache Software Foundation for projects and codebases wishing to become part of
the Foundation's efforts. 
Not all projects ['graduate'](https://incubator.apache.org/cookbook/#graduation_vote)
out of the Incubator; some are retired instead. Those retired projects remain under Incubator
oversight: the list may be found on the Incubator's
[Projects page](https://incubator.apache.org/projects/index.html#retired).

***
### Preview Website Color Schemes

[JustTheDocs](https://just-the-docs.github.io/just-the-docs/docs/configuration/#color-scheme)
comes with **Light** and **Dark** schemes and this website uses a custom
[Attic scheme]({{site.repo}}/blob/main/_sass/color_schemes/attic.scss),
which extends the **Light** scheme.

Click the buttons below to preview the different schemes:

<button class="btn js-toggle-light-mode">Light Scheme</button>
<button class="btn js-toggle-dark-mode">Dark Scheme</button>
<button class="btn js-toggle-attic-mode">Attic Scheme</button>

<script>
const toggleDarkMode = document.querySelector('.js-toggle-dark-mode');
jtd.addEvent(toggleDarkMode, 'click', function(){
  jtd.setTheme('dark');
});
const toggleLightMode = document.querySelector('.js-toggle-light-mode');
jtd.addEvent(toggleLightMode, 'click', function(){
  jtd.setTheme('light');
});
const toggleAtticMode = document.querySelector('.js-toggle-attic-mode');
jtd.addEvent(toggleAtticMode, 'click', function(){
  jtd.setTheme('attic');
});
</script>
