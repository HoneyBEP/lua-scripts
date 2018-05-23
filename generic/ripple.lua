--
-- Created by IntelliJ IDEA.
-- User: thomasoomens
-- Date: 22/05/2018
-- Time: 11:26
-- To change this template use File | Settings | File Templates.
--
package.path = './lua-scripts/lua/generic/util/?.lua;' .. package.path
local json = require "json"

function canHandle(request)
    doLog("info", "request received")
    return true
end

function handle(payload)
    local data = getRequest("1")
    if (data == "") then
        return "_return"
    end
    doLog("info", "Request: ".. data)
    local request = json.parse(data)
    send(data)
    doLog("info", "json test: ".. request.body.method)
    return "test"
end