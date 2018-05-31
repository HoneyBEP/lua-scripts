-- lua script for GPON exploit
local url = require "http/util/url"

function canHandle(message)
    if string.match(message, 'gpon.php') then
        return true
    end
    return false
end

function handle(message)
    local foundURL = url.retrieve(message);
    if (foundURL and string.match(foundURL, 'gpon.php')) then
        getFileDownload(foundURL, "downloads")
        return "wget: missing URL \nUsage: wget [OPTION]... [URL]... \n\nTry `wget --help' for more options.\n";
    end
    return message;
end