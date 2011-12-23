module(..., package.seeall);

require('os')

function split(path)
    local head = nil
    local tail = nil
    if type(path) == 'string' then
        head, tail = path:match('(/?.*)/(.*)')
    end
    return head, tail
end

function basename(path)
    local basename = nil
    _, basename = split(path)
    return basename
end

function dirname(path)
    local dirname = nil
    dirname, _ = split(path)
    return dirname
end

function join(...)
    local joinedpath = nil
    for i = 1,#arg do
        if joinedpath == nil or arg[i]:sub(1,1) == '/' then
            joinedpath = arg[i]
        else
            if joinedpath:sub(-1) ~= '/' then
                joinedpath = joinedpath .. '/'
            end
            joinedpath = joinedpath .. arg[i]
        end
    end
    return joinedpath
end

function normpath(path)
    local normpath = nil
    local parts = {}
    if path:sub(1,1) == '/' then
        parts[#parts + 1] = ''  -- insert empty space to create leading slash
    end
    for part in path:gmatch('[^/]+') do
        if part == '.' then
            -- pass
        elseif part == '..' then
            parts[#parts] = nil
        else
            parts[#parts + 1] = part
        end
    end
    if #parts == 0 then
        return '/'
    else
        return table.concat(parts, '/')
    end
end


function abspath(path)
    return normpath(join(cwd(), path))
end

function cwd()
    return io.popen('echo -n `pwd`'):read()
end

function exists(path)
    return (os.execute(string.format('stat %s > /dev/null 2>&1 ', path)) == 0)
end
