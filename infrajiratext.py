#!/usr/bin/env python3

"""

Find project resources for retired projects and generate JIRA issue text for INFRA:
- source control system (SVN or Git)
- dist.apache.org releases and dev
- mailing lists (Whimsy)
- JIRA https://issues.apache.org/jira/rest/api/2/project.json - detect if present
- LDAP project
- https://cwiki.apache.org/confluence/display/VXQUERY (e.g.)

"""

import sys
import subprocess
from urlutils import loadjson, urlexists

DEV="https://dist.apache.org/repos/dist/dev/"
REL="https://dist.apache.org/repos/dist/release/"
JIRA='https://issues.apache.org/jira/rest/api/2/project'
CWIKI='https://cwiki.apache.org/confluence/display/'
EMAIL='https://whimsy.apache.org/public/committee-retired.json'
GITBOX='https://gitbox.apache.org/repositories.json' # ['projects']


# =====================================

retired = loadjson(EMAIL)['retired']
gitbox = loadjson(GITBOX)['projects']

def check_wiki(pid):
    url = CWIKI + pid.upper()
    if urlexists(url):
        print("Make CWIKI readonly: %s" % url)

def check_mail(pid):
    try:
        mlists = retired[pid]['mlists']
        if len(mlists) > 0:
            print("Mailing lists https://lists.apache.org/list.html?%s.apache.org :" % pid)
            for mlist in mlists:
                print("- %s@%s.apache.org" % (mlist,pid))
            print()
    except KeyError:
        pass

def svnfiles(path):
    res = subprocess.run(["svn", "ls", path], capture_output=True)
    if res.returncode == 0:
        stdout = res.stdout
        if len(stdout) == 0:
            return 0
        if stdout == b'.htaccess\n': # just the htaccess file is OK
            return 0
        return 1
    else:
        stderr = res.stderr
        if b"W160013" in stderr: # no such item
            return -1
        print(stderr)
        return -1

def check_dist(pid):
    dev = svnfiles(DEV + pid)
    rel = svnfiles(REL + pid)
    if dev > 0 or rel > 0:
        if dev > 0:
            print("Remove the distribution SVN developer directory:")
            print('- ' + DEV + pid)
        if rel > 0:
            print("Remove the distribution SVN release directory contents, and")
            print("set up redirection to https://attic.apache.org/projects/%s.html" % pid)
            print('- ' + REL + pid)
        print()

# There is no anonymous access to LDAP now
# Assume there is a project LDAP group
def check_ldap(pid):
    BASE='ou=project,ou=groups,dc=apache,dc=org'
    print("Remove the LDAP project group: dn: cn=%s,%s" % (pid, BASE))

def check_jira(pid):
    jira = loadjson(JIRA)
    for project in jira:
        key = project['key']
        catname = ''
        if 'projectCategory' in project:
            catname = project['projectCategory']['name']
        if pid.upper() == key:
            if '(Retired)' in project['name'] or catname == 'Retired':
                pass
            else:
                print("Make the JIRA project https://issues.apache.org/jira/projects/%s read-only and flag as retired" % key)
        elif catname.lower() == pid:
            print("Make the JIRA project https://issues.apache.org/jira/projects/%s read-only and flag as retired" % key)

# check for SVN and Git
def check_scs(pid):
    svn = "https://svn.apache.org/repos/asf/%s" % pid
    if svnfiles(svn) > 0:
        print("Make SVN readonly: %s" % svn) # TODO what if this is the site SVN?
#         print("Update config file so commits go to attic ???")
    if pid in gitbox:
        print("Make the following git repos read-only https://gitbox.apache.org/repos/asf#%s :" % pid)
        for repo in gitbox[pid]['repositories']:
            print("- %s" % repo)
        print("Please do NOT rename the repos.")

if len(sys.argv) == 1:
    print("Please provide a list of project ids")
    sys.exit(1)

for arg in sys.argv[1:]:
    if not arg in retired:
        print("%s is not listed as a retired TLP" % arg)
        continue
#     with open('jira_%s.tmp' % arg, 'w') as f:
#         with redirect_stdout(f):
    print("%s project has retired." % retired[arg]['display_name'])
    print("The following resources were detected for archive/removal please:\n")
    check_dist(arg)
    check_mail(arg)
    check_jira(arg)
    check_scs(arg)
    check_wiki(arg)
    check_ldap(arg)
    print("Turn off any automated builds")
