local skynet = require "skynet"
require "skynet.manager"

-- 首页:         curl "http://ip:port"
-- 测试POST:     curl -X POST "http://ip:port/test"
-- 测试GET:      curl "http://ip:port/test"

local CMD = {}

function CMD.get_test(query, header, body)
    local ret = {
        query = query,
        header = header,
        body = body,
    }
    return ret
end

function CMD.post_test(query, header, body)
    local ret = {
        query = query,
        header = header,
        body = body,
    }
    return ret
end

skynet.start(function()
    skynet.register ".handler"
    skynet.dispatch("lua", function(_, _, cmd, ...)
        local f = CMD[cmd]
        if f then
            skynet.ret(skynet.pack(f(...)))
        else
            skynet.ret(skynet.pack("404 Not found", 404))
        end
    end)
end)

