#!/usr/bin/env tarantool
require('strict').on()

local spaces = require('create_spaces')
local users = require("create_users")
local vshard = require('vshard')
local cfg = require("cfg")
local json = require('json')

names = {
    ['storage_1_master'] = '8a274925-a26d-47fc-9e1b-af88ce939412',
    ['storage_2_master'] = '1e02ae8a-afc0-4e91-ba34-843a356b8ed7',
    ['storage_1and2_replica'] = '3de2e3e1-9ebe-4d0d-abb1-26d301b84633'}
    
replicasets = {'cbf06940-0790-498b-948d-042b62cf3d29',
               'ac522f65-aa94-4134-9f64-51ee384f1a54'}

vshard.storage.cfg(cfg.cfg, arg[1])

cfg.listen = 3300
vshard.router.cfg(cfg.cfg)

box.once('createUsers', users.createUsers)

-- create spaces
box.once('initUsersDB', spaces.initUsersDB)
box.once('initOrdersDB', spaces.initOrdersDB)
box.once('initHistoryDB', spaces.initHistoryDB)
box.once('initServicesDB', spaces.initServicesDB)
box.once('initAccountsDB', spaces.initAccountsDB)
box.once('initProxyDB', spaces.initProxyDB)
box.once('initQueue', spaces.InitQueue)

-- CRUD

function GetAll(JsonString)
    local space_name = json.decode(JsonString).space_name
    return box.space[space_name]:select()
end

function Get(JsonString)
    local space_name = json.decode(JsonString).space_name
    local tuple = CreateTuple(JsonString)

    return box.space[space_name]:select(tuple[1])
end

function Update(JsonString)
    local space_name = json.decode(JsonString).space_name
    local tuple = CreateTuple(JsonString)
    local i = 1
    for key, value in pairs(tuple) do
        if key ~= 1 then
            box.space[space_name]:update(tuple[1], {{'=', i, value}})
        end
        i = i +1
    end
    return Get(JsonString)
end

function Insert(JsonString)
    local space_name = json.decode(JsonString).space_name
    return box.space[space_name]:insert(CreateTuple(JsonString))
end

function Delete(JsonString)
    local space_name = json.decode(JsonString).space_name
    local tuple = CreateTuple(JsonString)

    return box.space[space_name]:delete(tuple[1])
end


-- implametation

function CreateTuple(JsonString)
    local ttable = ConvertJsonToTable(JsonString)
    return box.tuple.new(ttable)
end

function ConvertJsonToTable(JsonString)
    local numTable = json.decode(JsonString).numeric
    local model = json.decode(JsonString).model
    local ntable = {} local ktable = {} local rtable = {} local vtable = {}

    for key, value in pairs(numTable) do vtable = model[value] ntable[key] = vtable end
    for k in pairs(ntable) do table.insert(ktable, k) end
    table.sort(ktable)
    for _, k in ipairs(ktable) do table.insert(rtable, ntable[k]) end
    return rtable
end

-- test
function TestObjectLua(objectLua)
    return objectLua["space_name"]
end

function TestObjectLua1(objectLua)
    return objectLua.space_name
end



function TestRequest1(JsonString)
    return "1"
end

function TestRequest2(JsonString)
    return JsonString
end



function GetFuncname(JsonString)
    return json.decode(JsonString).function_name
end

function GetJsonData(JsonString)
    return json.decode(JsonString).JsonData
end

function GetBucketId(JsonString)
    return json.decode(JsonString).bucket_id
end




-- vshard

function CallReplica(JsonString)
    return vshard.router.callre(json.decode(JsonString).bucket_id, json.decode(JsonString).function_name, json.decode(JsonString).JsonData, {timeout = 10})
end

function CallMaster(JsonString)
    return vshard.router.callrw(json.decode(JsonString).bucket_id, json.decode(JsonString).function_name, json.decode(JsonString).JsonData, {timeout = 10})
end

function CallMasterJson(JsonString)
    return json.encode(vshard.router.callrw(json.decode(JsonString).bucket_id, json.decode(JsonString).function_name, json.decode(JsonString).JsonData, {timeout = 10}))
end

function TestCallJson(JsonString)
    local response = vshard.router.call(5000, 'write', "TestRequest1", JsonString, {timeout = 10})
    return json.encode(response)
end