#!/usr/bin/env python3

"""

Script to create retirement files for a project.

Input:
- https://whimsy.apache.org/public/committee-retired.json
- https://lists.apache.org/api/preferences.lua
- xdocs/projects/_template.xml
- _template.jira

Output:
- xdocs/flagged/<pid> (created)
- xdocs/projects/<pid>.xml (created)
- xdocs/stylesheets/project.xml (updated)
- cwiki_retired/<wiki_id>.txt (created)
- <pid>.jira.tmp (created) - this is for pasting into an Attic JIRA issue

N.B. The generated pid.xml file may need tweaking

"""

import sys
import os.path
from os.path import dirname, abspath, join
from inspect import getsourcefile
from string import Template
import os
import re
import subprocess
from collections import defaultdict
from urlutils import loadyaml, loadjson

if len(sys.argv) == 1:
    print("Please provide a list of project ids")
    sys.exit(1)

CWIKI='https://cwiki.apache.org/confluence/display/'

CWIKI_INFO='https://cwiki.apache.org/confluence/rest/api/space/?type=global&limit=1000'
WIKI_KEYS = defaultdict(list) # key = project name, value = list of possible spaces
for entry in loadjson(CWIKI_INFO)['results']:
    WIKI_KEYS[entry['name'].lower().replace('apache ', '')].append(entry['key'])

JIRA='https://issues.apache.org/jira/rest/api/2/project'

SVNURL='https://svn.apache.org/repos/asf/'
SVNKEYS = {}
svnargs = ['svn', 'ls', SVNURL]
output = subprocess.run(svnargs, stdout=subprocess.PIPE, check=True).stdout.decode("us-ascii")
for name in output.split('\n'):
    if len(name) > 0:
        SVNKEYS[name.rstrip('/')] = ''

GITREPOS='https://gitbox.apache.org/repositories.json'
GITKEYS = {}
for entry in loadjson(GITREPOS)['projects']:
    GITKEYS[entry] = ''

MYHOME = dirname(abspath(getsourcefile(lambda:0)))
PROJECTS =    join((MYHOME), 'xdocs', 'projects')
SYLESHEETS = join((MYHOME), 'xdocs', 'stylesheets')
FLAGGED = join((MYHOME), 'xdocs', 'flagged')
CWIKI_RETIRED = join((MYHOME), 'cwiki_retired')

#  get details of the retired projects
RETIREES = loadyaml('https://whimsy.apache.org/public/committee-retired.json')['retired']
lists = {}
for host,names in loadyaml('https://lists.apache.org/api/preferences.lua')['lists'].items():
    proj = host.replace('.apache.org','')
    if proj in RETIREES:
        lists[proj] = list(names.keys())

def list_jira(pid):
    jira = loadjson(JIRA)
    jiras = []
    for project in jira:
        key = project['key']
        catname = ''
        if 'projectCategory' in project:
            catname = project['projectCategory']['name']
        if pid.upper() == key:
            jiras.append(key)
        elif catname.lower() == pid:
            jiras.append(key)
    return jiras

# updates xdocs/stylesheets/project.xml
#    <li><a href="/projects/abdera.html">Abdera</a></li>
def update_stylesheet(pid):
    xmlfile = join(SYLESHEETS,'project.xml')
    xmlfilet = join(SYLESHEETS,'project.xml.t')
    print("Updating %s" % xmlfile)
    found = False
    with open(xmlfile,'r', encoding='utf-8') as r, open(xmlfilet,'w', encoding='utf-8') as w:
        for l in r:
            if not found:
                m = re.search(r'^(\s+<li><a href="/projects/)([^.]+)(.html">)[^<]+(</a></li>)', l)
                if m:
                    stem = m.group(2)
                    if stem == pid:
                        print("Already present in projects.xml")
                        print(l)
                        w.close()
                        os.remove(xmlfilet)
                        return
                    if stem > pid: # Found insertion point
                        found = True
                        name = RETIREES[pid]['display_name']
                        w.write("%s%s%s%s%s\n" % (m.group(1), pid, m.group(3), name, m.group(4)))
            w.write(l) # write the original line
    if found:
        print("Successfully added %s to %s" % (pid, xmlfile))
        os.system("diff %s %s" % (xmlfile, xmlfilet))
        os.rename(xmlfilet, xmlfile)
    else:
        print("Could not find where to add %s" % pid)

# create JIRA template
def create_jira_template(pid):
    outfile = join(MYHOME, "%s.jira.tmp" % pid)
    print("Creating %s" % outfile)
    with open(join(MYHOME, '_template.jira'), 'r', encoding='utf-8') as t:
        template = Template(t.read())
    out = template.substitute(tlpid = pid)
    with open(outfile, 'w', encoding='utf-8') as o:
        o.write(out)

# create the project.xml file from the template
def create_project(pid):
    outfile = join(PROJECTS, "%s.xml" % pid)
    print("Creating %s" % outfile)
    with open(join(PROJECTS, '_template.xml'), 'r', encoding='utf-8') as t:
        template = Template(t.read())
    meta = RETIREES[pid]
    mnames = lists[pid]
    mnames.remove('dev')
    jiras = list_jira(pid)
    # Is there a Wiki?
    cwikis = find_wiki(pid)
    if len(cwikis) > 0:
        if len(cwikis) == 1 and cwikis[0].lower() == pid:
            cwiki ='<cwiki/>'
        else:
            keys = ','.join(sorted(cwikis))
            cwiki =f'<cwiki keys="{keys}"/>'
    else:
        cwiki = ''
    svn = git = ''
    # May have both SVN and Git
    if pid in SVNKEYS:
        svn = '<svn/>'
    if pid in GITKEYS:
        git = '<git/>'
    out = template.substitute(tlpid = pid,
        FullName = meta['display_name'],
        Month_Year = meta['retired'],
        mail_names = ",".join(sorted(mnames)),
        jira_names = ",".join(sorted(jiras)),
        cwiki = cwiki,
        svn = svn,
        git = git,
        description = meta.get('description', 'TBA'))
    with open(outfile, 'w', encoding='utf-8') as o:
        o.write(out)
    os.system("git add %s" % outfile)
    print("Check XML file for customisations such as JIRA and mailing lists")

def find_wiki(pid):
    found = []
    for k, v in WIKI_KEYS.items():
        if k == pid or (k.startswith(pid)): # and not k == valid project name
            found += v
    return found

def check_wiki(pid):
    for wiki in find_wiki(pid):
        flagname = wiki.lower()
        flagfile = join(CWIKI_RETIRED, f"{flagname}.txt")
        with open(flagfile, 'w', encoding='utf-8') as w:
            if not flagname == pid:
                w.write(pid)
                w.write("\n")
        os.system("git add %s" % flagfile)

for arg in sys.argv[1:]:
    print("Processing "+arg)
    if not arg in RETIREES:
        print("%s does not appear to be a retired project" % arg)
        continue
    flagdir = join(FLAGGED, arg)
    if os.path.exists(flagdir):
        print("flagged/%s already exists" % arg)
        continue
    create_jira_template(arg)
    os.mkdir(flagdir)
    open(join(flagdir, "git.keep"), 'a').close()
    os.system("git add %s" % flagdir)
    create_project(arg)
    update_stylesheet(arg)
    check_wiki(arg)
