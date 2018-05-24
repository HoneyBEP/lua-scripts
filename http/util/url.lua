local url = {}

-- https://stackoverflow.com/questions/23590304/finding-a-url-in-a-string-lua-pattern

-- all characters allowed to be inside URL according to RFC 3986 but without
-- comma, semicolon, apostrophe, equal, brackets and parentheses
-- (as they are used frequently as URL separators)
function url.retrieve(message)
    local function max4(a,b,c,d) return math.max(a+0, b+0, c+0, d+0) end
    local protocols = {[''] = 0, ['http://'] = 0, ['https://'] = 0, ['ftp://'] = 0}
    local finished = {}

    for pos_start, foundURL, prot, subd, tld, colon, port, slash, path in
    message:gmatch'()(([%w_.~!*:@&+$/?%%#-]-)(%w[-.%w]*%.)(%w+)(:?)(%d*)(/?)([%w_.~!*:@&+$/?%%#=-]*))'
    do
        if protocols[prot:lower()] == (1 - #slash) * #path and not subd:find'%W%W'
                and (colon == '' or port ~= '' and port + 0 < 65536)
        then
            finished[pos_start] = true
            return foundURL
        end
    end

    for pos_start, foundURL, prot, dom, colon, port, slash, path in
    message:gmatch'()((%f[%w]%a+://)(%w[-.%w]*)(:?)(%d*)(/?)([%w_.~!*:@&+$/?%%#=-]*))'
    do
        if not finished[pos_start] and not (dom..'.'):find'%W%W'
                and protocols[prot:lower()] == (1 - #slash) * #path
                and (colon == '' or port ~= '' and port + 0 < 65536)
        then
            return foundURL
        end
    end

    return nil
end

return url

