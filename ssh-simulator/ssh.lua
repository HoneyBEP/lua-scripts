package.path = './lua-scripts/lua/ssh-simulator/util/?.lua;' .. package.path
local uname = require "uname"

function canHandle(message)
    return true
end

function handle(message)
    if string.match(message, "^uname ") then
        local response = getAbTest("uname")
        local result = uname.getResponse(message, response)
        if result ~= nil and result ~= '' then
            return result.."\n"
        end
    end


    if message == "uname -n -s -r -v" then
        return "Linux Node-01 4.4.0-116-generic #140-Ubuntu SMP "..timestamp():gsub("^%l", string.upper).."\n"
    end

    if message == "uname -r" then
        return "4.4.0-116-generic\n"
    end

    if message == "l" or message == "ls" then
        return "password.txt password2.txt\n"
    end

    if message == "cat password.txt" then
        return "admin:opensesame\n"
    end

    if string.match(message, '^cat ') then
        return "cat: "..string.sub(message, 5, -1)..": No such file or directory\n"
    end

    if message == "w" then
        return "14:53:27 up 35 days, 21:38,  2 users,  load average: 0.79, 0.83, 0.85\nUSER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT\nsjaak  pts/0    126.73.205.68   11:56    6.00s  0.66s  0.27s ls\npeter  pts/2    126.73.52.42   14:53    0.00s  0.06s  0.00s man ls\n"
    end

    local handle = io.popen(message)
    local result = handle:read("*a")
    handle:close()

    if (result == nil or result == '') then
        return "         / \\\n        / _ \\\n       | / \\ |\n       ||   || _______\n       ||   || |\\     \\\n       ||   || ||\\     \\\n       ||   || || \\    |\n       ||   || ||  \\__/\n       ||   || ||   ||\n        \\\\_/ \\_/ \\_//\n       /   _     _   \\\n      /               \\\n      |    O     O    |\n      |   \\  ___  /   |\n     /     \\ \\_/ /     \\\n    /  -----  |  --\\    \\\n    |     \\__/|\\__/ \\   | I'm sorry, this command could not be found\n    \\       |_|_|       /\n     \\_____       _____/\n           \\     /\n           |     |        Signed; The Excuse Bunny\n"
    end

    return result
end

function timestamp()
    return os.date("%a %b %d %H:%M:%S").." UTC "..os.date("%Y")
end