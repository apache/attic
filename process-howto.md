---
layout: page
title: Attic Process - How To
parent: Process
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

# Attic Process - How To
***

{: .fs-5}
The sections below describe *How To* complete the various tasks to be done by Attic team for retiring a project and moving it to The Apache Attic:

  - [1. Confirm Board Resolution](#1-confirm-board-resolution)
  - [2. Create project page on Attic site:](#2-create-project-page-on-attic-site)
  - [3. Inform users of the move to the Attic](#3-inform-users-of-the-move-to-the-attic)
  - [4. Update the project DOAP file (if any):](#4-update-the-project-doap-file-if-any)
  - [5. Get infra lock down project's resources](#5-get-infra-lock-down-projects-resources)
  - [6. Announce on announce@apache.org](#6-announce-on-announceapacheorg)

The following are useful Git/svn/https locations:

  - permissions on svn [/repos/asf](https://github.com/apache/infrastructure-p6/blob/production/modules/subversion_server/files/authorization/asf-authorization-template#L231)
    and [/repos/infra](https://github.com/apache/infrastructure-p6/blob/production/modules/subversion_server/files/authorization/pit-authorization-template)
  - websites [svnpubsub](https://github.com/apache/infrastructure-p6/blob/production/modules/svnwcsub/files/svnwcsub.conf) and
    [infra-reports#sitesource](https://infra-reports.apache.org/#sitesource)

## 1. Confirm Board Resolution

Check previous Board minutes to confirm the "terminate" resolution passed. The minutes are available from the following sources:

  - The private [committers@a.o mailing list](https://lists.apache.org/list.html?committers@apache.org:lte=2M:ASF%20Board%20Meeting) (requires login)
  - Previously published [Board meeting minutes](https://www.apache.org/foundation/board/calendar.html)
  - Whimsy has a public list of [Board Minutes by topic](https://whimsy.apache.org/board/minutes/)

However note that the most recent meeting minutes are not published until the following meeting at the earliest.

Check that Secretary removed the PMC from [https://svn.apache.org/repos/private/committers/board/committee-info.txt](https://svn.apache.org/repos/private/committers/board/committee-info.txt)
(see also [commits history](https://lists.apache.org/list.html?committers-cvs@apache.org)).

This automatically removes VP entry on [https://www.apache.org/foundation/leadership](https://www.apache.org/foundation/leadership)
([src](https://github.com/apache/www-site/blob/main/content/foundation/leadership.ezmd)) and project from
[https://www.apache.org/#projects-list](https://www.apache.org/#projects-list) navigation
([src](https://github.com/apache/www-site/blob/main/content/index.ezmd#L304)): see [www-site](https://github.com/apache/www-site)
and its rendered HTML in [asf-site](https://github.com/apache/www-site/tree/asf-site) branch.

## 2. Create project page on Attic site:
**https://attic.apache.org/projects/${project}.html**

You can create a PR for the `${project}.yaml` file using the GitHub Action
[Generate PR to add _data/projects/pid.yaml file](https://github.com/apache/attic/actions/workflows/retire.yml).

Click on 'Run workflow' and enter the lower case project id.
If the id is valid, the workflow will create a PR to add the YAML file.
The workflow will also build a preview version of the website from the PR branch.

Once the PR has been checked and applied, the site will be regenerated.
The project details will be found at [https://attic.apache.org/projects/${project}.html](https://attic.apache.org/projects/)
and associated retirement WIP templates at [https://attic.apache.org/templates/${project}.html](https://attic.apache.org/templates/)

A sample ATTIC Jira template can be found on that page.
Note that the project YAML file will need to be updated to add the ATTIC Jira issue number once it has been created.

Once the page is live and Jira issue is created, follow steps and update issue state:
  - Check the project site carries the **Attic Banner**
  - Check any CWIKI spaces carry the  **Attic Banner**
  - Use the project's [Template Page]({% link tracking.md %}) to help with:
    - Creating the INFRA Jira
    - Templates for User & Announcement Emails

## 3. Inform users of the move to the Attic

Once the project page is live on the Attic website, you can use the project's
[Template Page]({% link tracking.md %}) to get a project specific text for the
User email.

The text will be based on the following template, replaced with project specific values.

```
{% include user-email-template.html name="${project}" attic_issue="ATTIC-${#}" %}
```

Remember to [subscribe](https://www.apache.org/foundation/mailinglists.html) to the user
list: use [Whimsy Mailing List Self-subscription](https://whimsy.apache.org/committers/subscribe)
to avoid moderation (if the project hasn't been removed yet).

Also bear in mind that the user mailing list may already know and you can skip this stage,
or you can get help from project having asked to move to the Attic. Make sure you read that 
thread if it does exist.

## 4. Update the project DOAP file (if any):
**https://projects.apache.org/project.html?${project}**

The DOAP files (used for [projects directory](https://projects.apache.org/projects.html)) are referenced
in [projects.apache.org `data/projects.xml`](https://github.com/apache/comdev-projects/blob/trunk/data/projects.xml),
which every Apache committer can update (in [svn](https://svn.apache.org/repos/asf/comdev/projects.apache.org/trunk/data)).

Identify whether the project being terminated has a DOAP `.rdf` file,
and update the DOAP `.rdf` file:
1. change PMC to the Attic,
2. add [_retired_](https://projects.apache.org/projects.html?category#retired) category (keep original categories, as they remain valid for the project)

```
pmc change:    <asfext:pmc rdf:resource="http://attic.apache.org" />
add category:  <category rdf:resource="http://projects.apache.org/category/retired" />
```

You can use [`script/project2attic.py`](https://github.com/apache/comdev-projects/blob/trunk/scripts/project2attic.py) to prepare the update that you'll just need to
review and commit.

## 5. Get infra lock down project's resources

Open an [Infrastructure Jira](https://issues.apache.org/jira/browse/INFRA) issue identifying
the resources that need turning off/making read only.

Once the project page is live on the Attic website, you can use the project's
[Template Page]({% link tracking.md %}) to get project specific content for
the Infrastructure JIRA.

Typically, it contains steps like following, that need to be tweaked based on assets of the retired project:

  - Make source control Git\|Svn read-only
  - Remove files from [dist.apache.org/repos/dist/\[release\|dev\]](https://dist.apache.org/repos/dist/)
  - Closing down of dev@, commits@ and private@ etc. [mailing lists](https://lists.apache.org/)
  - Close down the user mailing list (unless still active - in which case propose a moderator to Infra)
  - Make JIRA\|Bugzilla read-only
  - Make the wiki (if any) read-only
  - Delete LDAP group(s)
  - Turn off automated builds

## 6. Announce on announce@apache.org

Announce that the project [is now retired](https://lists.apache.org/list?announce@apache.org:lte=1M:%22is%20now%20retired%22).

Once the project page is live on the Attic website, you can use the project's
[Template Page]({% link tracking.md %}) to get a project specific text for the
Announcement email.

The text will be based on the following template, replaced with project specific values.

Sometimes, the user mailing list will not be shut down. If that is the case,
it should be mentioned in the announce. e.g. add "The user mailing list remains open."
after "change in url." below.

```
{% include announce-email-template.html project_id="${project}" name="${project}" longname="${project}" description="${project} was {boilerplate}" %}
```

It's important to include the boilerplate from the project's site so people know what we're talking about.
