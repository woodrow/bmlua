module(..., package.seeall);

function strip(s)
    return (s:gsub('^%s+', ''):gsub('%s+$', ''))
end

function split(s, sep_pattern, keep_empty)
    if sep_pattern == nil then  -- emulate python behavior
        sep_pattern = '%s+'
        s = strip(s)
    else
        sep_pattern = sep_pattern:gsub('([%^%$%(%)%%%.%[%]%*%+%-%?])', '%%%1')
        sep_pattern = '[' .. sep_pattern .. ']'
    end
    if keep_empty == nil then -- keep empty fields -- default=true
        keep_empty = true
    end

    local parts = {}
    local start = 1
    local tok_s
    local tok_e
    while s:find(sep_pattern, start) do
        tok_s,tok_e = s:find(sep_pattern, start)
        if keep_empty or (tok_s - 1 - start) > 0 then
            parts[#parts + 1] = s:sub(start, tok_s - 1)
        end
        start = tok_e + 1
    end
    if start <= #s then
        parts[#parts + 1] = s:sub(start)
    end
    return parts
end
