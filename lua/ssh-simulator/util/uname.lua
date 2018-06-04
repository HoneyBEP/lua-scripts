local uname = {}

function uname.getResponse(message, response)
    local responseElements = uname.split(response, "##")
    local responseKeys = {"s", "o", "m", "p", "i", "M", "v", "r"}
    local unameParams = {}

    for elementCount = 1, #responseElements do
        unameParams[responseKeys[elementCount]] = responseElements[elementCount]
    end

    if message == "uname -a" then
        message = "uname -m -n -r -s -v"
    end

    local t = {}
    for p in message:gmatch(" (-%a)") do
        t[#t + 1] = unameParams[p:match("%a")]
    end

    return table.concat(t, " ")
end

function uname.split(s, delimiter)
    local result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

return uname