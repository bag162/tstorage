#!/usr/bin/env tarantool
require('strict').on()

local spaces = require('create_spaces')
local users = require("create_users")
local vshard = require('vshard')
local cfg = require("cfg")
local json = require('json')

vshard.storage.cfg(cfg.cfg, arg[1])
cfg.listen = 3300
vshard.router.cfg(cfg.cfg)

box.once('createUsers', users.createUsers)
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

CrudFuncs = {
    GetAll = GetAll(),
    Get = Get(),
    Update = Update(),
    Insert = Insert(),
    Delete = Delete()
}

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

-- vshard

function CallReplica(JsonString)
    return CrudFuncs[json.decode(JsonString).function_name](json.decode(JsonString).JsonData)
end

function CallMaster(JsonString)
    return CrudFuncs[json.decode(JsonString).function_name](json.decode(JsonString).JsonData)
end