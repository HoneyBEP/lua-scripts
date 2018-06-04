local uname = {}

function uname.getResponse(message, response)
    local responseElements = uname.split(response, "##")
    local responseKeys = {"s", "o", "m", "p", "i", "M", "v", "r"}
    local uname = {}

    for elementCount = 1, #responseElements do
        uname[responseKeys[elementCount]] = responseElements[elementCount]
    end

    if message == "uname -a" then
        message = "uname -m -n -r -s -v"
    end

    local t = {}
    for p in message:gmatch(" (-%a)") do
        t[#t + 1] = uname[p:match("%a")]
    end

    return table.concat(t, " ");
end

function uname.split(s, delimiter)
    local result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

return uname