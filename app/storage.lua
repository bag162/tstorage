#!/usr/bin/env tarantool

require('strict').on()
require('business_logic.crud')
require('business_logic.implementation')
require('business_logic.queue_implementation')
require('business_logic.orders_implementation')
require('fibers.InitTaskQueue')
require('Init.spaces')
require('Init.users')
require('Init.testdata')

cfg = require('Init.cfg')
vshard = require('vshard')
log = require('log')
fiber =  require('fiber')
json = require('json')

local tableDetect = {
    ['2a0a:2b41:e:693c::']='8a274925-a26d-47fc-9e1b-af88ce939412', -- master 1 -- переделать в json, где добавить мастер это или нет, что бы запускались файбера только на мастерах
    ['2a0a:2b41:c:67d6::']='3de2e3e1-9ebe-4d0d-abb1-26d301b84633' -- mater 2
}
local uuid = tableDetect[require('http.client').get('http://ip.bablosoft.com/').body]

vshard.storage.cfg(cfg.cfg, uuid)
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
if uuid == "8a274925-a26d-47fc-9e1b-af88ce939412" then
    fiber.create(InsertCheckProxyTask)
    fiber.create(InsertCheckAccountTask)
    fiber.create(CheckCreateOrderTuplesTask)
    fiber.create(CheckDeleteOrderTuplesTask)
    LoadTestData()
end

function CallReplica(JsonString)
    -- return vshard.router.callre()
    return _G[json.decode(JsonString).function_name](json.decode(JsonString).JsonData)
end

function CallMaster(JsonString)
    -- return vshard.router.callre()
    return _G[json.decode(JsonString).function_name](json.decode(JsonString).JsonData)
end
-- test
-- test 2