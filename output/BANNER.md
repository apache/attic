# How Attic banners are created

Attic banners are added to HTML pages using an OutputFilter configured on a webserver.
The filter modifies the page content before it is returned to the browser.

There are two different types of banner: for Confluence and for project websites.
Both use Lua (via the mod_lua httpd module), and are activated by marker files or directories,

## Confluence (cwiki.apache.org)

Before returning a web-page, the server checks if either of the following files exists:
- /etc/apache2/attic/<wikiname-lowercase>.txt
- /etc/apache2/retired_podlings/<wikiname-lowercase>.txt

If so, it enables the output filter, passing it the directory name and the Parent (Attic or Incubator)

By default, the filter assumes that the lower-case wiki name is the same as the project or podling name.
This can be overridden by the contents of the txt file.
Multiple Wikis can be associated with a single project or podling in this way.

The .txt files on the wiki server are sourced from the branch [cwiki-retired](https://github.com/apache/attic/tree/cwiki-retired)
The branch is populated during the attic site build from entries in the YAML files under
https://github.com/apache/attic/blob/main/_data/projects/

For example [OLTU](https://github.com/apache/attic/blob/main/_data/projects/oltu.yaml#L22-L26)

## Project websites ({project}.apache.org)

Project websites are served from a single host, known as the tlp server.

Before returning a web-page, the server checks if the following directory exists:
- /www/attic.apache.org/output/flagged/<hostname>

If so, it enables the [Lua filter](https://github.com/apache/attic/blob/asf-site/output/scripts/attic_filter.lua).
The filter has access to the request host name, which is used to generate the link back to the Attic project page.
The default behaviour of the filter outputs the Attic banner at the very beginning of the page.
This is not valid HTML, but seems to work in most cases.
For hosts that have incompatible HTML, the filter has several options for changing the way the banner is added.
The relevant option is selected based on the hostname.

The directories are created in the `asf-site` branch as part of the website build.
Not all retired projects need the banner, as some early retirements were handled by updating the source web pages.
The directory is only created if the relevant project yaml file includes the setting `attic_banner: true`,
for example [griffin](https://github.com/apache/attic/blob/f163250900a3bb3dda627094527c87669d5d47b5/_data/projects/griffin.yaml#L5)
