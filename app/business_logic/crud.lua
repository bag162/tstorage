local json = require('json')
local log = require('log')

local function FillNilValuesInTuple(tuple)
    local updatedTable = tuple:totable()
    for key, value in pairs(updatedTable) do
        if value == nil then
            updatedTable[key] = "null"
        end
    end
    return box.tuple.new(updatedTable)
end

function GetAll(JsonString)
    if JsonString == nil then
        return nil
    end
    
    local space_name = json.decode(JsonString).space_name
    return box.space[space_name]:select()
end
 
function Get(JsonString)
    if JsonString == nil then
        return nil
    end
    
    local space_name = json.decode(JsonString).space_name
    local index = json.decode(JsonString).index_name
    local index_value;
    local index_type = json.decode(JsonString).type_index

    if index_type == "string" then
        index_value = json.decode(JsonString).index_value
    elseif 1 == 1 then
        index_value = tonumber(json.decode(JsonString).index_value)
    end

    return box.space[space_name].index[index]:select(index_value)
end

function Update(JsonString)
    if JsonString == nil then
        return nil
    end
    local space_name = json.decode(JsonString).space_name local i = 1
    local tuple = FillNilValuesInTuple(CreateTuple(JsonString))
    for key, value in pairs(tuple) do
        if key ~= 1 then
            box.space[space_name]:update(tuple[1], {{'=', i, value}})
        end
        i = i +1
    end
    return box.space[space_name]:select(tuple[1])[1]
end

function Insert(JsonString)
    if JsonString == nil then
        return nil
    end
    
    local space_name = json.decode(JsonString).space_name
    local inserted_tuple = FillNilValuesInTuple(CreateTuple(JsonString))
    return box.space[space_name]:insert(inserted_tuple)
end

function Delete(JsonString)
    if JsonString == nil then
        return nil
    end

    local space_name = json.decode(JsonString).space_name
    local tuple = CreateTuple(JsonString)
    return box.space[space_name]:delete(tuple[1])
end