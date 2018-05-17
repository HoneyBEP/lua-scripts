-- lua script for GPON exploit
package.path = './lua-scripts/lua/http/util/?.lua;' .. package.path
local url = require "url"

function canHandle()
    return true
end

function handle(message)
    print(message)
    local foundURL = url.retrieve(message);
    if (foundURL and string.match(foundURL, 'gpon.php')) then
        getFileDownload(foundURL, "downloads")
        return "wget: missing URL \nUsage: wget [OPTION]... [URL]... \n\nTry `wget --help' for more options.\n";
    end
    return message;
end