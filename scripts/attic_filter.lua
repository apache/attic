--[[
  This is an output filter for HTML files
  It adds a banner for projects that are flagged as in the attic.

  It is invoked by the tlp vhosts if the following directory exists:
  /var/www/attic.apache.org/flagged/%{HTTP_HOST}

  See the tlp vhost definitions in https://github.com/apache/infrastructure-p6/blob/production/data/roles/tlpserver.yaml

  The mod_lua API is described here:
  https://httpd.apache.org/docs/current/mod/mod_lua.html#modifying_buckets

  How it works:
    For simplicity, we add the banner to the start of the page.

    This is not really valid HTML, but seems to work in most cases, and avoids having to find a better
    place to insert it. It does not work for some hosts, especially those that have a static menu bar
    with scrolling content. In such cases, the code looks for a specific tag (which should only occur once
    in any of the site pages, otherwise two banners may be added) and adds the banner either before or after it.

    The best location for this is found by trial and error:
    - download a copy of a page
    - move the banner from the start of the page (where it is added by default) and try it in various
    other parts of the page.
    - try the same in some other pages that have a different layout.
    - repeat until a suitable location is found and find a tag or other string that uniquely identifies it
    - add the host-specific processing to the filter along the lines of the existing host exceptions

  Note: This filter was introduced in April 2018, so not all projects in the Attic use this filter.
  Previously the project websites themselves were changed.
]]--

-- hostnames that need special processing
-- keys are the host names, values are the style of edit needed
local OVERRIDES = {
  predictionio = 'a',
  mxnet = 'b',
  twill = 'c',
  eagle = 'd',
  metamodel = 'e',
  abdera = 'f',
  wink = 'f',
  tiles = 'g',
  lenya = 'h',
  whirr = 'h',
  mrunit = 'i',
  -- Shorthand names for testing using VAR_NAME override
  _a = 'a',
  _b = 'b',
  _c = 'c',
  _d = 'd',
  _e = 'e',
  _f = 'f',
  _g = 'g',
  _h = 'h',
  _i = 'i',
}

function output_filter(r)
    -- We only filter text/html types
    if not r.content_type:match("text/html") then return end

    -- get TLP part of hostname
    local host = r.hostname:match("^([^.]+)")

    -- create the customised banner
    local divstyle = 'font-size:x-large;padding:15px;color:white;background:red;z-index:99;' ;
    local astyle = 'color:white;text-decoration:underline' ;
    local div = ([[
      <div style='%s'>
        This project has retired. For details please refer to its
        <a style='%s' href="https://attic.apache.org/projects/%s.html">
        Attic page</a>.
      </div>]]):format(divstyle, astyle, host)

    -- Javadoc uses frames, so link needs to open in new page
    local divnew = ([[
      <div style='%s'>
        This project has retired. For details please refer to its
        <a style='%s' href="https://attic.apache.org/projects/%s.html" target="_blank">
        Attic page</a>.
      </div>]]):format(divstyle, astyle, host)

    -- add header:
    -- special processing needed for some hosts
    local style = OVERRIDES[host]
    if style
    then
        coroutine.yield('')
    else
        coroutine.yield(div)
    end

    -- spit out the actual page
    while bucket ~= nil do
        local output
        -- special processing needed for hosts as above
        if style == 'a'
        then
            output = bucket:gsub('<header>', '<header>'..div, 1)
        elseif style == 'b'
        then
            output = bucket:gsub('</header>', div..'</header>', 1)
        elseif style == 'c'
        then
            -- Fix for Javadocs: </header> does not appear in them, and
            -- topNav only appears in the Javadoc pages that can take the div without failing
            output = bucket:gsub('</header>', div..'</header>', 1):gsub('<div class="topNav">', divnew..'<div class="topNav">', 1)
        elseif style == 'd'
        then
            output = bucket:gsub('</nav>', '</nav>'..div, 1)
        elseif style == 'e'
        then
            output = bucket:gsub('</nav>', div..'</nav>', 1):gsub('<div class="topNav">', divnew..'<div class="topNav">', 1)
        elseif style == 'f' -- old-style Java and project websites
        then
            output = bucket:gsub('<body>', '<body>'..div, 1):gsub('<A NAME="navbar_top">', divnew..'<A NAME="navbar_top">', 1)
        elseif style == 'g'
        then
            local body = '<body class="topBarEnabled">'
            local javadoc = '<div class="topNav">'
            output = bucket:gsub(body, body..div, 1):gsub(javadoc, divnew..javadoc, 1)
        elseif style == 'h' -- old-style Javadoc fixup only
        then
            output = bucket:gsub('<A NAME="navbar_top">', divnew..'<A NAME="navbar_top">', 1)
        elseif style == 'i' -- Javadoc fixup only
        then
            local javadoc = '<!-- ========= START OF TOP NAVBAR ======= -->'
            output = bucket:gsub(javadoc, javadoc..divnew, 1)
        else
            output = bucket
        end
        coroutine.yield(output)
    end

    -- no need to add anything at the end of the content

end
