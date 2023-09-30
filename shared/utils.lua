--
-- utils.lua
--

function _d(fn)
    if Config.Debug then
        fn()
    end
end

function toUppercaseFirst(s)
    return (s:sub(1,1):upper()..s:sub(2))
end