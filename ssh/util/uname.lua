local uname = {}

function uname.getResponse(message)
    local unameCommand = {
        { -- busybox_w32_32x
            s = "Windows_NT",
            o = "MS/Windows",
            m = "i686",
            p = "unknown",
            i = "unknown",
            M = "unknown",
            v = "9200",
            r = "6.2",
        },
        { -- busybox_w32_64x
            s = "Windows_NT",
            o = "MS/Windows",
            m = "x86_64",
            p = "unknown",
            i = "unknown",
            M = "unknown",
            v = "3790",
            r = "5.2",
        },
    }

    if string.match(message, "^uname ") then
        local uname = unameCommand[math.random(#unameCommand)]
        local t = {}
        for p in message:gmatch(" (-%a)") do
            t[#t + 1] = uname[p:match("%a")]
        end

        return table.concat(t, " ")
    end

    return nil
end

return uname