local json = require "generic/util/json"


local function read_file(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end

function canHandle(request)
    doLog("info", "request received")
    return true
end

function handle(payload)
    local data = getRequest("1")
    if (data == "") then
        return "_return"
    end
    local request = json.parse(data)
    local body = request.body
    local headers = [[{ "content-type": "application/json", "server": "ripple-json-rpc/rippled-0.90.1" }]]

    channelSend(data)

    doLog("info", "Incoming data:".. data)

    --  Todo: implement all methods from this url:  https://developers.ripple.com/public-rippled-methods.html
    if (setContains(body, "method")) then
        local response = getMethod(body.method, body.params[1])
        if (not response) then
            restWrite("200", [[{"error": "Unknown method"}]])
        end
        restWrite("200", json.stringify(response), headers)
    else
        restWrite("200", [[{"error": "Invalid call"}]])
    end


    return "_return"
end

function setContains(set, key)
    doLog("info", "setContains key: ".. key)
    return set[key] ~= nil
end

function getMethod(method, data)
    local methodResponses = json.parse(read_file(getFolder() .. "/generic/data/ripple.json"));
    if (setContains(methodResponses, method)) then
        local result = json.stringify(methodResponses[method])
        for key, value in pairs(data) do
            result = string.gsub(result, "%$".. key .."%$", value)
        end
        return json.parse(result)
    end
    return false
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end