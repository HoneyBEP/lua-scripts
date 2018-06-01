local uname = require "ssh-simulator/util/uname"

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

    local result = ""
    -- Run command on shell
    -- local handle = io.popen(message)
    -- local result = handle:read("*a")
    -- handle:close()

    if (result == nil or result == '') then
        match = string.match(message, "%w+")
        return match .. ": command not found\n"
    end

    return result
end

function timestamp()
    return os.date("%a %b %d %H:%M:%S").." UTC "..os.date("%Y")
end
