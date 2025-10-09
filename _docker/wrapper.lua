--[[
    This wrapper modifies the hostname in the argument passed to the filter handler.
]]
require 'attic_filter'

function output_filter_wrapper(r)
    -- copy the variables needed by attic_filter, overriding hostname
    -- it's not possible to update hostname in the userdata (r), so we provide a replacment which uses the same syntax
    s = {}
    -- Copy across the items need by the filter.
    s['content_type'] = r.content_type
    s['hostname'] = os.getenv('VAR_NAME') or 'localhost'
    -- For local debugging, also add the following:
    s['warn'] = function(self, txt)
        r:warn(txt)
    end
    output_filter(s) -- call with updated settings
end
