-- lua script for HTTP exploit
package.path = './scripts/lua/http/util/?.lua;' .. package.path
local url = require "url"

function canHandle(message)
    return true
end

function handle(message)
    local questions = {
        "I consent that all information entered will be stored?",
        "I consent that all uploads will be stored?",
        "I consent that all your complete session will be recorded?",
        "I consent that information will be shared with others?",
        "I consent that information will be shared with research institutes?",
        "I consent that information will stored for eternity?",
    }
    local html = '<html><head><title>DutchSec - HoneyTrap</title></head><body><script>'

    for key, question in pairs(questions) do
        html = html .. 'if (confirm("'.. question ..'")) {'
    end

    for key, question in pairs(questions) do
        html = html .. '}'
    end

    html = html .. '</script><h1>Test! Test! Test!</h1></body></html>'

    return html
end
