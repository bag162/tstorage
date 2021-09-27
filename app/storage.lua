#!/usr/bin/env tarantool
require('strict').on()

require('strict').on()
require('business_logic.crud')
require('business_logic.implementation')
require('business_logic.queue_implementation')
require('business_logic.orders_implementation')
require('fibers.InitTaskQueue')
require('Init.spaces')
require('Init.users')
cfg = require('Init.cfg')

vshard = require('vshard')
log = require('log')
fiber =  require('fiber')
json = require('json')

vshard.storage.cfg(cfg.cfg, arg[1])
cfg.listen = 3300
vshard.router.cfg(cfg.cfg)


-- init users and roles
box.once('createUsers', CreateUsers)
-- init spaces and indexes
box.once('initUsersDB', InitUsersDB)
box.once('initOrdersDB', InitOrdersDB)
box.once('initHistoryDB', InitHistoryDB)
box.once('initServicesDB', InitServicesDB)
box.once('initAccountsDB', InitAccountsDB)
box.once('initProxyDB', InitProxyDB)
box.once('initQueue', InitQueue)
-- init fibers
if arg[1] == "8a274925-a26d-47fc-9e1b-af88ce939412" then
    fiber.create(InsertCheckProxyTask)
    fiber.create(InsertCheckAccountTask)
    fiber.create(CheckCreateOrderTuplesTask)
    fiber.create(CheckDeleteOrderTuplesTask)

-- load test Data TODO: Delete on realise
    
end

function CallReplica(JsonString)
    -- return vshard.router.callre()
    return _G[json.decode(JsonString).function_name](json.decode(JsonString).JsonData)
end

function CallMaster(JsonString)
    -- return vshard.router.callre()
    return _G[json.decode(JsonString).function_name](json.decode(JsonString).JsonData)
end