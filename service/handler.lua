local skynet = require "skynet"
require "skynet.manager"

-- 首页:         curl "http://ip:port"
-- 测试POST:     curl -X POST "http://ip:port/test"
-- 测试GET:      curl "http://ip:port/test"

local CMD = {}

local function syscmd(cmd)
  skynet.error("syscmd. cmd:", cmd)
  local pfile = io.popen(cmd .. " 2>&1")
  local ret = pfile:read("a")
  pfile:close()
  return ret
end

function CMD.get_startskynet(query, header, body)
  local cmd = "bash startskynet.sh"
  local ret = syscmd(cmd)
  return ret
end

function CMD.get_startskynet2(query, header, body)
  local cmd = "python2 startskynet.py"
  local ret = syscmd(cmd)
  return ret
end

function CMD.get_startskynet3(query, header, body)
  local cmd = "python3 startskynet.py"
  local ret = syscmd(cmd)
  return ret
end

function CMD.get_stopskynet(query, header, body)
  local cmd = "bash stopskynet.sh"
  local ret = syscmd(cmd)
  return ret
end

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

