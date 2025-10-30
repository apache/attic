# Docker build for testing Attic banner and CSP.

The instructions below assume that Docker has been installed and started.
Also Docker must be given access to the Attic checkout directory.

Most docker commands must be run from the top-level of an Attic checkout,
i.e. the directory which contains the files `Dockerfile` and `compose.yaml`

## Build the image

`docker compose build`

## Setting up to test against a local copy of the website

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

Alternatively, define the variable VAR_ATTIC=yes when starting the container.

## Setting up to test against an external website source

The Docker container can fetch web pages from a remote source.
This can be a project website, or it can be the website source as held in
Subversion or Git (must be accessible via http(s))

Set the VAR_HOSTURL variable to the source, e.g. `VAR_HOSTURL=https://attic.apache.org`

## Fixing the banner display

If the banner does not display correctly (e.g. it may be partially hidden under the menu bar),
you can try to see if any of the existing filter overrides work.
Use one of the shorthand style names (currently _a, _b ..._e) as the VAR_NAME value
in the docker command below instead of the target sitename.

e.g. `VAR_NAME=_c ... docker compose up`

You can quickly check all the existing overrides using this method.

## Testing against download cgi pages

To process download cgi pages, you will need access to
the closer_cgi/files directory in the private infrastructure-p6 repository. 
If not available, such pages will fail to load, but the site should otherwise work OK.

## Starting the container

Start container for local copy:
`[VAR_DYN=/path/to/closer_cgi/files] VAR_HTML=/path/to/website VAR_NAME=sitename [VAR_ATTIC=yes] docker compose up`

Start container for external website:
`[VAR_DYN=/path/to/closer_cgi/files] VAR_HOSTURL=https://.../ VAR_NAME=sitename [VAR_ATTIC=yes] docker compose up`

Browse to localhost:8000

## Other container commands

Start shell (container must be running):
`docker compose exec attic_lua_csp /bin/bash`

Restart httpd server
`docker compose exec attic_lua_csp apache2ctl restart`

Stop httpd server (and the container):
`docker compose exec attic_lua_csp apache2ctl stop`

Start the container and run bash rather than the webserver:
`docker compose run --rm --entrypoint /bin/bash attic_lua_csp`

## Changing the Content-Security-Policy

To change the local CSP exceptions, define the variable CSP_PROJECT_DOMAINS, for example:
`VAR_HOSTURL=https://.../ VAR_NAME=sitename CSP_PROJECT_DOMAINS="host1 host2" docker compose up`

To make changes to the base CSP, edit the 
file [_docker/000-default.conf#L9-L17](https://github.com/apache/attic/blob/main/_docker/000-default.conf#L9-L17)
Then rebuild the image (should be very quick) and restart.

## Variables used to customise the container

- VAR_NAME: override the default request hostname (generally required)
- VAR_ATTIC: set to 'yes' to enable banner processing (default 'no')
- VAR_LEVEL: webserver log level (e.g. debug, tracen) (default 'info')
- VAR_DYN: (optional) path to closer_cgi files
- VAR_HTML: path to website source (defaults to internal website with single page)
- VAR_HOSTURL: (optional) if defined, must point to website base url, e.g. https://attic. apache.org/
