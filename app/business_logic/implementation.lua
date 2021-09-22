local json = require('json')
local log = require('log')

local function sortFunc(a, b)
    return (tonumber(a) < tonumber(b))
end

function CreateTuple(JsonString)
    local ttable = ConvertJsonToTable(JsonString)
    return box.tuple.new(ttable)
end

function ConvertJsonToTable(JsonString)
    local numTable = json.decode(JsonString).numeric
    local model = json.decode(JsonString).model
    local ntable = {} local ktable = {} local rtable = {} local vtable = {}
    for key, value in pairs(numTable) do ntable[key] = model[value] end
    for k in pairs(ntable) do table.insert(ktable, k) end
    table.sort(ktable, sortFunc)
    for _, k in ipairs(ktable) do table.insert(rtable, ntable[k]) end
    return rtable
end

function Array_length(array)
 
    local len = 0
    for _,_ in pairs(array) do
        len = len + 1
    end
 
    return len
end