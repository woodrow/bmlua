module(..., package.seeall);

function islice(t, first, last)
    local slice = {}
    if first > 0 and last <= #t then
        for i=first,last do
            slice[#slice + 1] = t[i]
        end
    end
    return slice
end

function print(t, indent)
    if indent == nil then
       indent = ""
    end
    for k,v in pairs(t) do
        if type(v) == 'table' then
            _G.print(string.format("%s%s: {", indent, k))
            print(v, indent .. '  ')
            _G.print(string.format("%s}", indent))
        else
            _G.print(string.format("%s%s: %s", indent, k, tostring(v)))
        end
    end
end


