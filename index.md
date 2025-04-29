<?xml version="1.0"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one
  or more contributor license agreements.  See the NOTICE file
  distributed with this work for additional information
  regarding copyright ownership.  The ASF licenses this file
  to you under the Apache License, Version 2.0 (the
  "License"); you may not use this file except in compliance
  with the License.  You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing,
  software distributed under the License is distributed on an
  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  KIND, either express or implied.  See the License for the
  specific language governing permissions and limitations
  under the License. 
-->
<document>
  <properties>
    <author email="general.AT.attic.apache.DOT.org">The Apache Software Foundation</author>
    <title>The Apache Attic</title>
  </properties>
<body>

<section id="attic">
  <title>The Apache Attic</title>

  <p>
    The Apache Attic was created in 
    <a href="https://www.apache.org/foundation/records/minutes/2008/board_minutes_2008_11_19.txt">November 2008</a> 
    to provide process and solutions to make it clear when an Apache project has reached its 
    end of life. Specifically:
  </p>
  <blockquote style="font-family: monospace">
    the Apache Attic Project [...] is responsible for the oversight of projects which otherwise would not have oversight; <br />
    the Apache Attic Project [...] is not authorized to actively develop and release the projects under its oversight
  </blockquote>

  <p>It is intended to: </p>
  <ul>
    <li>Be non-impacting to users</li>
    <li>Provide restricted oversight for these codebases</li>
    <li>Provide oversight for active user lists with no Project Management Committee (PMC)</li>
  </ul>

  <p>It is not intended to: </p>
  <ul>
    <li>Rebuild community</li>
    <li>Make bugfixes</li>
    <li>Make releases</li>
  </ul>
</section>

<section id="incoming">
  <title>Getting into the Attic</title>

  <p>There are two expected mechanisms by which a project may enter the Attic. Either the managing 
     Project Management Committee (PMC) decides it would like to move the project, or The 
     Apache Software Foundation's board dissolves the PMC and chooses to move the project. </p>

  <p>First step is to add a suitable resolution to the next board agenda: see the <a href="resolution.html">Template Board Resolution</a>.</p>

  <p>Once the submitted resolution has been approved during a board meeting, the Attic project starts executing the move.</p>
</section>

<section id="candidates">
  <title>When should a project move to the Attic?</title>

  <p>Projects whose PMC are unable to muster 3 votes for a release, who have no active committers or 
     are unable to fulfill their reporting duties to the board are all good candidates for the Attic. </p>
</section>

<section id="process">
  <title>Process of moving into the Attic</title>

  <p>This is defined in greater details in the separate <a href="process.html">process</a> document. </p>

</section>

<section id="departure">
  <title>Process of leaving the Attic again</title>

  <p>Options are: </p>
  <ul>
    <li>Forking the project outside the Apache Software Foundation - we'll link to any forks which have been
      created so please let us know</li>
    <li>Restarting the project at the Apache Software Foundation, with multiple ways to do so:
      <ul>
      <li>Restarting the community in the Apache Incubator</li>
      <li>Recreating a PMC for the project</li>
      <li>Transfering to an existing PMC</li>
      </ul>
    </li>
  </ul>

<p>
A receiving PMC must be willing to assume all responsibilities that come
with running a project: maintain code, answer questions, fix bugs,
publish releases etc.
<br/>
If the Board does not object, PMC Attic will transfer the project's
assets (code-base, TLP website, maven group-id etc) to the receiving PMC.
<br/>
After the transfer the receiving PMC will report to the Board about the
project's activities, and publish project releases in the PMC's dist area. 
</p>

</section>

<section id="contact">
  <title>Contacting the Attic Project</title>

  <p>The Attic is a project as any other:</p>
  <ul>
  <li>It is managed by a <a href="https://projects.apache.org/committee.html?attic">Project Management Committee (PMC)</a>.</li>
  <li>Public discussions happen on a mailing list:
     see <a href="https://lists.apache.org/list.html?general@attic.apache.org">general@attic.apache.org</a> archive.
     You are welcome to subscribe and engage discussion. </li>
  </ul>
</section>

<section id="incubator">
  <title>Retired Incubator Projects</title>

  <p>The <a href="https://incubator.apache.org/">Apache Incubator project</a> is the entry path into The Apache Software Foundation for projects
   and codebases wishing to become part of the Foundation's efforts.
   Not all projects <a href="https://incubator.apache.org/cookbook/#graduation_vote">'graduate'</a> out of the Incubator; some are retired instead.
   Those retired projects remain under Incubator oversight: the list may be found on the Incubator's 
   <a href="https://incubator.apache.org/projects/index.html#retired">Projects page</a>. </p>

</section>

</body>
</document>
