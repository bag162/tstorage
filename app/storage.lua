#!/usr/bin/env tarantool

local spaces = require('create_spaces')
local users = require("create_users")
local vshard = require('vshard')
local cfg = require("cfg")

local names = {
    ['storage_1_master'] = '8a274925-a26d-47fc-9e1b-af88ce939412',
    ['storage_2_master'] = '1e02ae8a-afc0-4e91-ba34-843a356b8ed7',

    ['storage_1_replica'] = '3de2e3e1-9ebe-4d0d-abb1-26d301b84633',
    ['storage_2_replica'] = '001688c3-66f8-4a31-8e19-036c17d489c2',
}

vshard.storage.cfg(cfg.cfg, arg[1])

-- creating users and giving them grants
box.once('createUsers', users.createUsers)

-- create spaces
box.once('initUsersDB', spaces.initUsersDB)
box.once('initOrdersDB', spaces.initOrdersDB)
box.once('initHistoryDB', spaces.initHistoryDB)
box.once('initServicesDB', spaces.initServicesDB)
box.once('initAccountsDB', spaces.initAccountsDB)
box.once('initProxyDB', spaces.initProxyDB)
box.once('initQueue', spaces.InitQueue)

function GetOrderTask()
    local space = box.space.queue;

    local tasks = space:select({"0"},{iterator='GT',offset=1,limit=1})
    local task = tasks[1]

    if task ~= nil then
        box.space.queue:delete(task[1])
        return task
    end

    return nil
end

function CheckTuple(string)
    return string
end

function CheckQueue(tuple)
    local newtuple = box.tuple.new{tuple[1], tuple[2], tuple[3], tuple[4], "test"}
    return newtuple
end

function AddQueue(tuple)
    box.space.tester:insert{tuple[1], tuple[2], tuple[3], tuple[4], "test"}
    return box.tuple.new{tuple[1], tuple[2], tuple[3], tuple[4], "test"}
end