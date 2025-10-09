Docker build for testing Attic banner and CSP.

Build:
`docker compose build`

Checkout the website to be tested in a spare directory, e.g.
- `git clone [-b BRANCH --single-branch] https://github.com/apache/xyz-site /path/to/repo`
or
- `svn co https://svn-master.apache.org/repos/asf/xyz/site/trunk/ /path/to/repo`

Check the location of the source on the following Infra page:
https://infra-reports.apache.org/#sitesource

Some sites are served from a subdir of the repository, e.g. /path/to/repo/content
This is shown as /path/to/website in the following descriptions

To enable/disable the Attic banner, create/delete the directory (not a file!):
`mkdir /path/to/website/_ATTIC`

Alternatively, define the variable VAR_ATTIC=yes

If the banner does not display correctly (e.g. it may be partially hidden under the menu bar),
you can try to see if any of the existing filter overrides work.
Use one of the shorthand style names (currently _a, _b ..._e) as the VAR_NAME value
in the docker command below instead of the target sitename.
You can quickly check all the existing overrides using this method.

To process download cgi pages, you will need access to
the closer_cgi/files directory in the private infrastructure-p6 repository. 
If not available, such pages will fail to load, but the site should otherwise work OK.

Start:
`[VAR_DYN=/path/to/closer_cgi/files] VAR_HTML=/path/to/website VAR_NAME=sitename [VAR_ATTIC=yes] docker compose up`

Browse to localhost:8000

Start shell (container must be running):
`docker compose exec attic_lua_csp /bin/bash`

Restart httpd server
`docker compose exec attic_lua_csp apachectl restart`

Stop httpd server (and the container):
`docker compose exec attic_lua_csp apachectl stop`

To make changes to the CSP, edit the 
file [_docker/000-default.conf#L9-L17](https://github.com/apache/attic-docker/blob/main/_docker/000-default.conf#L9-L17)
Then rebuild the image (should be very quick) and restart.
