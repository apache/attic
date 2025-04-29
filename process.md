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
    <title>Moving a PMC to the Attic</title>
  </properties>
<body>

<section id="moving">
  <title>Moving a PMC to the Attic</title>

  <p>At some point a PMC may want to join the Attic. The following defines a process
     to move that PMC into the Attic and gently close it down. </p>

  <ol>
    <li>A PMC decides to move to the Attic. 
      <ul>
        <li>Conduct a discussion on the public developer list whether to dissolve the PMC. Do not conduct it on the private PMC list.</li>
        <li>Consider an appeal to the user list for interested users to provide their interest in helping out more.</li>
        <li>Consider whether any contributors might be candidates for promotion to committers or PMC members.</li>
        <li>Conduct a PMC vote on the public dev list. </li>
        <li>If the PMC votes to dissolve the PMC and move to the Attic, inform the board of the successful vote on board@ mailing list (linking or forwarding the 'successful' vote) and add a <a href="resolution.html">resolution</a> to dissolve the PMC to the next board meeting agenda. </li>
        <li>If the PMC can't get enough people to vote to dissolve the PMC (and there are not three -1 votes), then that is grounds for moving to the Attic. They should inform the board as above, noting that the vote failed to get enough votes. </li>
      </ul>
    </li>
    <li>If the board approves the resolution, open an <a href="https://issues.apache.org/jira/browse/ATTIC">Attic JIRA</a> item - 'Move ${project} to the Attic'.<br />
      The Attic PMC will step in and create a detailed issue description using <a href="https://github.com/apache/attic/blob/main/retire.py"><code>retire.py</code></a>, with other generated parts to move the project to the Attic.<br />
      Generated issue content typically contains following steps (see <a href="#howto">"How to"</a> below for a description of each step): 
      <ol type="1">
        <li><a href="#confirm-resolution">#</a> Confirm Board Resolution</li>
        <li><a href="#informing">#</a> Inform users of the move to the Attic</li>
        <li><a href="#atticsite">#</a> Create project page on Attic site: https://attic.apache.org/projects/$project.html</li>
        <li><a href="#doap">#</a>Update the project DOAP files (if any) or copy to <a href="https://svn.apache.org/repos/asf/comdev/projects.apache.org/trunk/data/projects-override/">projects-override</a></li>
        <li><a href="#infra">#</a>Get infra lock down project's resources</li>
        <li><a href="#announce">#</a> Announce on <a href="https://lists.apache.org/list?announce@apache.org:lte=1M:%22is%20now%20retired%22">announce at apache.org</a></li>
      </ol>
      The Attic PMC will then execute the steps: getting help from terminating project is welcome, particularly on informing users step or any other useful action at project's level like modifying DOAP.
    </li>
  </ol>

</section>

<section id="General-pointers">
  <title>How to: General pointers</title>
  <a name="howto"/>

  <p>The following are useful Git/svn/https locations:</p>
    <ul>
     <li>site <a href="https://attic.apache.org">https://attic.apache.org</a>, with its source <a href="https://github.com/apache/attic">https://github.com/apache/attic</a>,
       <a href="https://github.com/apache/attic/actions">built</a> to <a href="https://github.com/apache/attic/tree/asf-site">asf-site</a></li>
     <li>jira <a href="https://issues.apache.org/jira/browse/ATTIC">https://issues.apache.org/jira/browse/ATTIC</a></li>
     <li>permissions on svn <a href="https://github.com/apache/infrastructure-p6/blob/production/modules/subversion_server/files/authorization/asf-authorization-template#L231">/repos/asf</a>
     and <a href="https://github.com/apache/infrastructure-p6/blob/production/modules/subversion_server/files/authorization/pit-authorization-template">/repos/infra</a></li>
     <li>websites <a href="https://github.com/apache/infrastructure-p6/blob/production/modules/svnwcsub/files/svnwcsub.conf">svnpubsub</a> and
         <a href="https://infra-reports.apache.org/#sitesource">infra-reports#sitesource</a></li>
    </ul>
</section>

<section id="confirm-resolution">
  <title>How to: 1. Confirm Board Resolution</title>
  <p>Check previous Board minutes to confirm the "terminate" resolution passed. The minutes are available from the following sources:</p>
  <ul>
  <li>The private <a href="https://lists.apache.org/list.html?committers@apache.org:lte=2M:ASF%20Board%20Meeting">committers@a.o mailing list</a> (requires login)</li>
  <li>Previously published <a href="https://www.apache.org/foundation/board/calendar.html">Board meeting minutes</a></li>
  <li>Whimsy has a public list of <a href="https://whimsy.apache.org/board/minutes/">Board Minutes by topic</a></li>
  </ul>
  <p>However note that the most recent meeting minutes are not published until the following meeting at the earliest.</p>
  <p>Check that Secretary removed the PMC from <a href="https://svn.apache.org/repos/private/committers/board/committee-info.txt">https://svn.apache.org/repos/private/committers/board/committee-info.txt</a>
  (see also <a href="https://lists.apache.org/list.html?committers-cvs@apache.org">commits history</a>).
  </p>
  <p>This automatically removes VP entry on <a href="https://www.apache.org/foundation/leadership">https://www.apache.org/foundation/leadership</a> (<a href="https://github.com/apache/www-site/blob/main/content/foundation/leadership.ezmd">src</a>)
     and project from <a href="https://www.apache.org/#projects-list">https://www.apache.org/#projects-list</a> navigation (<a href="https://github.com/apache/www-site/blob/main/content/index.ezmd#L304">src</a>):
     see <a href="https://github.com/apache/www-site">www-site</a> and its rendered HTML in <a href="https://github.com/apache/www-site/tree/asf-site">asf-site</a> branch.</p>.
</section>

<section id="informing">
  <title>How to: 2. Inform users of the move to the Attic</title>

  <p>Let the users know that the PMC is moving into the Attic. Use the following template: </p>
  <pre>
A heads up for the ${project} user community that the ${project} PMC has 
been 'moved to the Attic'. This means that the ${project} developers (more 
formally its Project Management Committee) have voted to retire ${project} 
and move the responsibility for its oversight over to the Attic project.

Loosely speaking this means that the projects resources will be moved to a 
read-only state.

You can read more about the Apache Attic and the process of moving to the 
Attic at https://attic.apache.org.

You can follow this process in JIRA: 
 
  https://issues.apache.org/jira/browse/ATTIC-${#}

Thanks,

${Name} on behalf of ${project} + the Attic.
  </pre>

  <p>Remember to <a href="https://www.apache.org/foundation/mailinglists.html">subscribe</a> to the user list: use <a href="https://whimsy.apache.org/committers/subscribe">Whimsy Mailing List Self-subscription</a> to avoid moderation (if the project hasn't been removed yet).</p>
  <p>Also bear in mind that the user mailing list may already know and you can skip this stage, or you can get help from project having asked to move to the Attic. Make sure you read that thread if it does exist. </p>
</section>

<section id="atticsite">
  <title>How to: 3. Create project page on Attic site: https://attic.apache.org/projects/${project}.html</title>

  <p>The Attic website is built using Anakia. <a href="https://velocity.apache.org/anakia/">Anakia</a> is an old site technology built on top of Apache Velocity. 
     You can get the source for the site from Git: </p>
  <pre>git clone https://github.com/apache/attic</pre>

  <p>You can generate the required changes using the Python3 <a href="https://github.com/apache/attic/blob/main/retire.py"><code>retire.py</code></a> script as follows:</p>
  <pre>./retire.py id1 [id2...]</pre>
  <p>This should generate the following files for each ID, as well as updating <code>xdocs/stylesheets/project.xml</code>:</p>
  <ul>
    <li><code>ID.jira.tmp</code></li>
    <li><code>xdocs/flagged/ID</code> (this is a directory, used to add the Attic banner)</li>
    <li><code>xdocs/projects/ID.xml</code></li>
    <li><code>cwiki_retired/WIKI_ID.txt</code> (this adds the CWIKI banner for projects)</li>
  </ul>
  <p>The code allows for wiki aliases, as described in the <code>cwiki_retired/AAREADME.txt</code> file.</p>
  <p>Review the changes in <code>xdocs/</code>, then commit to Git.</p>
  <p>The <code>ID.jira.tmp</code> file is text that can be copy-pasted into a JIRA description. It should be deleted after use, and not committed to Git.</p>
</section>

<section id="doap">
    <title>How to: 4. Update the project DOAP file (if any): https://projects.apache.org/project.html?${project}</title>

    <p>The files referenced are in <a href="https://svn.apache.org/repos/asf/comdev/projects.apache.org/trunk">https://svn.apache.org/repos/asf/comdev/projects.apache.org/trunk</a>, which every Apache committer can update.</p>

    <p>Identify whether the project has a DOAP file (see the &lt;comdev repo&gt;/projects.apache.org/data/projects.xml file) and update the rdf file with PMC to the Attic and add a category of <em>retired</em>: </p>
     <pre>pmc change:    &lt;asfext:pmc rdf:resource="http://attic.apache.org" /&gt;
new category:  &lt;category rdf:resource="http://projects.apache.org/category/retired" /&gt;</pre>
    <p>You can use <code>script/project2attic.py</code> to prepare the update that you'll just need to review and commit</p>
</section>

<!--section id="PMCdata">
    <title>How to: 5.iii Move committee's PMC data file to retired</title>

    <p>If committee appears in <a href="https://projects.apache.org/committees.html">committees list</a>, moving data to retired will remove it from the list:</p>
    <ul>
      <li>comment PMC data files index entry (see the <a href="https://svn.apache.org/repos/asf/comdev/projects.apache.org/trunk/data/committees.xml">committees.xml</a> file
       and old <a href="https://svn.apache.org/repos/asf/infrastructure/site-tools/trunk/projects/pmc_list.xml">pmc_list.xml</a> file)</li>
      <li>move PMC data file
       from <a href="https://svn.apache.org/repos/asf/comdev/projects.apache.org/trunk/data/committees">committees/</a> directory
       to <a href="https://svn.apache.org/repos/asf/comdev/projects.apache.org/trunk/data/committees-retired">committees-retired/</a></li>
    </ul>
</section-->

<section id="infra">
  <title>How to: 5. Get infra lock down project's resources</title>
  <p>Open an <a href="https://issues.apache.org/jira/browse/INFRA">Infrastructure JIRA</a> issue identifying the resources that need turning off/making read only.</p>

  <p>The content of the issue can be generated using <a href="hhttps://github.com/apache/attic/blob/main/infrajiratext.py"><code>infrajiratext.py</code></a>.</p>

  <p>Typically, it contains steps like following, that need to be tweaked based on assets of the retired project:
    <ul>
      <li>Make source control Git|Svn read-only</li>
      <li>Remove files from <a href="https://dist.apache.org/repos/dist/">dist.apache.org/repos/dist/[release|dev]</a></li>
      <li>Closing down of dev@, commits@ and private@ etc. <a href="https://lists.apache.org/">mailing lists</a></li>
      <li>Close down the user mailing list (unless still active - in which case propose a moderator to Infra)</li>
      <li>Make JIRA|Bugzilla read-only</li>
      <li>Make the wiki (if any) read-only</li>
      <li>Delete LDAP group(s)</li>
      <li>Turn off automated builds</li>
    </ul>
  </p>
</section>

<section id="announce">
  <title>How to: 6. Announce on announce@apache.org</title>

  <p>Announce that the project <a href="https://lists.apache.org/list?announce@apache.org:lte=1M:%22is%20now%20retired%22">is now retired</a>. Consider the following template.</p>
  <p>Sometimes, the user mailing list will not be shut down.
  If that is the case, it should be mentioned in the announce.
  e.g. add "The user mailing list remains open." after "change in url." below.
  </p>

  <pre>
Announcing that the Apache ${project} committers have voted to retire
the project due to inactivity. ${project} was {boilerplate}.

Retiring a project is not as simple as turning everything off, as
existing users need to both know that the project is retiring and
retain access to the necessary information for their own development
efforts.

You can read more about ${project}'s retirement at:

   https://attic.apache.org/projects/${project}.html

The project's resources will continue to be available in a read-only state -
website, mailing lists, wikis, git, downloads and bug tracker with no 
change in url.

Providing process and solutions to make it clear when an Apache
project has reached its end of life is the role of the Apache Attic,
and you can read more about that at:

   https://attic.apache.org/

Thanks,

${NAME}
on behalf of the Apache Attic and the now retired Apache ${project} project
  </pre>

  <p>It's important to include the boilerplate from the project's site so people 
     know what we're talking about.</p>
</section>

</body>
</document>
