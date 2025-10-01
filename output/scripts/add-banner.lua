-- This file is probably obsolete; the TLP server now uses attic_filter.lua

local posix = require 'posix'
local TEMPL = [=[
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Project !PROJ! is retired.</title>
<meta HTTP-EQUIV="content-type" CONTENT="text/html; charset=utf-8">
<style type="text/css">
<!--/* <![CDATA[ */
div.top
  { font-size : xx-large ;
    padding : 15px ;
    color : white ;
    background-color : red ;
  }
div.top a:link    { color : white ; }
div.top a:visited { color : white ; }
span.urly { color : blue ; text-decoration : underline }
/* ]]> */-->
</style>
<script>//<![CDATA[
function initialize ()
  { console.log ( 'initialize' ) ;
    resize() ;
    if ( window.self != window.top )
      { var win1 = window.top.document.getElementById("f2").contentWindow
        var win2 = window.self.document.getElementById("f2").contentWindow
        win1.location.href = win2.location.href
        console.log ( 'window.self != window.top' )
        console.log ( 'promote to : ' + win1.location.href )
      }
    else
      { console.log ( 'window.self == window.top' ) ; }
  }

function resize ()
  { console.log ( 'resize' ) ;
    console.log ( 'innerHeight[%s]', window.innerHeight ) ;
    var f1h = document.getElementById("f1").clientHeight ;
    var w_w = window.innerWidth  ;
    var w_h = window.innerHeight ;
    var f_w = 0.99 * w_w ;
    var f_h = w_h - f1h - 50 ;
    document.getElementById("f2").width  = f_w ;
    document.getElementById("f2").height = f_h ;
    console.log ( 'f2.height[%s]', document.getElementById("f2").height ) ;
  }

function change_loc()
  { console.log ( 'change_loc' ) ;
    var top = document.getElementById("top") ;
    var loc = document.getElementById("loc") ;
    var f2  = document.getElementById('f2') ;
    try { f2.contentWindow.location.href ; }
    catch ( exception )
      { console.log ( 'exception ' + exception ) ;
        top.innerHTML = "Left <i>!HOST!</i> ..."
        loc.innerHTML = '<p><span style="color:red">'
          + '<b>[to leave frame]</b></span> '
          + 'Use the <i><b>show only this frame</b></i> function '
          + 'of your browser.'
        return ;
      }
    var url = '<a href="https://attic.apache.org/projects/!PROJ!.html">'
      + 'attic page</a>'
    top.innerHTML = "Project <i>!PROJ!</i> is retired ; "
      + "for details, see !PROJ!'s " + url + '.'
    loc.innerHTML = '<p>location: '
      + f2.contentWindow.location.pathname
  }
//]]></script>
</head>

<body onload="initialize()" onresize="resize()">
  <div id="f1">
  <div id="top" class="top"></div>
  <span id='loc'></span>
  </div>
  <iframe id="f2" onload="change_loc()" src="/FRAME/!PATH!"></iframe>
</body>
</html>
]=]

local PROG  = '/scripts/add-banner.lua/' ;
local ATTIC_DIR  = '/var/www/attic.apache.org/'
local ATTIC_PRJS = ATTIC_DIR .. 'flagged/'

function exists(f)   return posix.stat(f) ~= nil end
function in_attic(p) return exists ( ATTIC_PRJS .. p ) end

function handle(r)
  local get = r:parseargs()
  local err = nil
  local HOST = r.hostname
  local PROJ, _ = string.gsub ( HOST, '.apache.org', '' )
  local PATH = r.path_info
  local TEST = false

  r.content_type = "text/html"

  -- r:puts ( r.unparsed_uri .. "<br>\n" )
  -- for k, v in pairs ( get ) do
  --   r:puts( string.format("arg [%s] [%s]<br>\n", k, v) )
  -- end

  if not TEST and not get.test and not in_attic(HOST) then
    err = "project is not in attic"
      .. " PROJ [" .. PROJ .. "]"
      .. " HOST [" .. HOST .. "]"
      .. " PATH [" .. PATH .. "]"
  end

  if err ~= nil then
    r:puts(err)
  else
    local text = TEMPL
    local subs =
      { ['!PROJ!'] = PROJ
      , ['!HOST!'] = HOST
      , ['!PATH!'] = PATH
      }
    for k, v in pairs ( subs ) do text, _ = string.gsub ( text, k, v ) end
    r:puts(text)
  end
  return apache2.OK
end
