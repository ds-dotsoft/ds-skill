--
-- utils.lua
--

function ServerLog(_type, log)
    if Config.Debug then
        local color = _type == "success" and "^2" or "^1"
        print(("^8[ds-crypto]%s %s^7"):format(color, log))
    end
end

function _d(fn)
    if Config.Debug then
        fn()
    end
end

function dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k,v in pairs(o) do
            if type(k) ~= "number" then k = "..k.." end
            s = s .. "["..k.."] = " .. dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

function contains(thing, value)
    for _, v in ipairs(thing) do
        if v == value then
            return true
        end
    end

    return false
end

function booltonumber(value)
    if value then
        return 1
    end

    return 0
end

function foreach(t, fn)
    for _, v in pairs(t) do
        fn(v)
    end
end

function foreachk(t, fn)
    for k, v in pairs(t) do
        fn(k, v)
    end
end

function foreachi(t, fn)
    for _, v in ipairs(t) do
        fn(v)
    end
end

function foreachik(t, fn)
    for k, v in ipairs(t) do
        fn(k, v)
    end
end

function toUppercaseFirst(s)
    return (s:sub(1,1):upper()..s:sub(2))
end

function math.randomchoice(table)
    local keys = {}
    for key, value in pairs(table) do
        keys[#keys + 1] = key
    end
    index = keys[math.random(1, #keys)]
    return table[index]
end