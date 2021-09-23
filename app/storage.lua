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
    local uuid = require('uuid')
    box.space.account:insert{
    uuid.str(),
    'blondgal',
    'z8w4lr6l6n',
    '16263614690',
    '{"cookies":[{"domain":"www.textnow.com","expires":-1,"httpOnly":true,"name":"_csrf","path":"","priority":"Medium","secure":true,"session":true,"size":77,"value":"s%3AKzeHsKRp_fXYU6UYgV6f07gB.bJJRPpWJi9nLaBMMp8DI4CtK6XCKrUvgB9Z3ptrKa9U"},{"domain":".textnow.com","expires":1695075467,"httpOnly":false,"name":"_ga","path":"","priority":"Medium","secure":false,"session":false,"size":29,"value":"GA1.2.905830144.1632003456"},{"domain":".textnow.com","expires":1632089867,"httpOnly":false,"name":"_gid","path":"","priority":"Medium","secure":false,"session":false,"size":31,"value":"GA1.2.1341481505.1632003456"},{"domain":".textnow.com","expires":1632003516,"httpOnly":false,"name":"_gat","path":"","priority":"Medium","secure":false,"session":false,"size":5,"value":"1"},{"domain":".google.com","expires":1647814655.0493701,"httpOnly":true,"name":"NID","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":178,"value":"511=E-o4hDpqDIMoEWcqr2nX0Om_4K3os3fGXapUMFVtOPms3ioepSHdFu6uscUUC5rUShLF4wkHKwrJzEmA4JGLN6CcMveoMLmYHj5aaKuC7qCHKWO-jrXP3jhTfRUJhUu8Ok3InrURnuv3lNOlUhuJNG9AJOmzWIlElFrU0CAztgg"},{"domain":".www.textnow.com","expires":253402257600,"httpOnly":false,"name":"G_ENABLED_IDPS","path":"","priority":"Medium","secure":false,"session":false,"size":20,"value":"google"},{"domain":".textnow.com","expires":-1,"httpOnly":false,"name":"pxcts","path":"","priority":"Medium","sameSite":"Lax","secure":false,"session":true,"size":41,"value":"3a5150e0-18ce-11ec-91bb-33036eb911a7"},{"domain":".textnow.com","expires":1663539456,"httpOnly":false,"name":"_pxvid","path":"","priority":"Medium","sameSite":"Lax","secure":false,"session":false,"size":42,"value":"3a49cdda-18ce-11ec-8221-675556505477"},{"domain":"www.textnow.com","expires":1939587456,"httpOnly":false,"name":"tatari-cookie-test","path":"","priority":"Medium","secure":false,"session":false,"size":26,"value":"57975064"},{"domain":".textnow.com","expires":1632003756,"httpOnly":false,"name":"t-ip","path":"","priority":"Medium","secure":false,"session":false,"size":5,"value":"1"},{"domain":".textnow.com","expires":1939587456,"httpOnly":false,"name":"tatari-session-cookie","path":"","priority":"Medium","secure":false,"session":false,"size":57,"value":"627c8119-0398-149f-8ebc-56512970963d"},{"domain":".textnow.com","expires":1639779457,"httpOnly":false,"name":"_gcl_au","path":"","priority":"Medium","secure":false,"session":false,"size":31,"value":"1.1.583545999.1632003457"},{"domain":".intljs.rmtag.com","expires":1663539457.885545,"httpOnly":false,"name":"rmuid","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":41,"value":"d691275b-1e73-434a-b9bc-cc8b128dafff"},{"domain":".intljs.rmtag.com","expires":1663539457.8856831,"httpOnly":false,"name":"icts","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":24,"value":"2021-09-18T22:17:37Z"},{"domain":".linksynergy.com","expires":1663539459.8738041,"httpOnly":false,"name":"icts","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":24,"value":"2021-09-18T22:17:38Z"},{"domain":".textnow.com","expires":1663539818,"httpOnly":false,"name":"stc117823","path":"","priority":"Medium","secure":false,"session":false,"size":269,"value":"tsa:1632003458521.991720013.0034204.7150890459102723.1:20210918224738|env:1%7C20211019221738%7C20210918224738%7C1%7C1073241:20220918221738|uid:1632003458519.1172727968.899218.117823.1175717171.:20220918221738|srchist:1073241%3A1%3A20211019221738:20220918221738"},{"domain":".sitescout.com","expires":1663539458.830451,"httpOnly":false,"name":"ssi","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":53,"value":"9537595e-3c7b-48d5-a389-887fb9b7068c#1632003458519"},{"domain":".linksynergy.com","expires":1663539459.873642,"httpOnly":false,"name":"rmuid","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":41,"value":"e918ef25-f39d-416c-8f7e-e9f392cbdd61"},{"domain":".nr-data.net","expires":-1,"httpOnly":false,"name":"JSESSIONID","path":"","priority":"Medium","sameSite":"None","secure":true,"session":true,"size":26,"value":"8831db1a33b82174"},{"domain":".sitescout.com","expires":1634595459.8276889,"httpOnly":false,"name":"_ssuma","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":130,"value":"eyIzNCI6MTYzMjAwMzQ1ODcyMCwiMiI6MTYzMjAwMzQ1ODcyMCwiNCI6MTYzMjAwMzQ1ODcyMCwiMzkiOjE2MzIwMDM0NTg3MjAsIjciOjE2MzIwMDM0NTg3MjB9"},{"domain":".rlcdn.com","expires":1663539459.3754449,"httpOnly":false,"name":"rlas3","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":49,"value":"GsuM2ABeL56pu7Yt0kx83VNMaRtH6HiHfXdAy30a+y8="},{"domain":".teads.tv","expires":1663453059.2458861,"httpOnly":false,"name":"tt_viewer","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":45,"value":"dd03a6a9-7b07-4731-8156-ea9269c60693"},{"domain":".rlcdn.com","expires":1637187459.3755929,"httpOnly":false,"name":"pxrc","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":32,"value":"CIPLmYoGEgUI6AcQABIGCOTrARAA"},{"domain":".demdex.net","expires":1647555459.5405431,"httpOnly":false,"name":"demdex","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":44,"value":"13416204905266713521596538407434047150"},{"domain":".tapad.com","expires":1637187459.615087,"httpOnly":false,"name":"TapAd_TS","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":21,"value":"1632003459319"},{"domain":".tapad.com","expires":1637187459.6152351,"httpOnly":false,"name":"TapAd_DID","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":45,"value":"df257270-a1df-4067-8297-3991da072f12"},{"domain":".dpm.demdex.net","expires":1647555459.5404179,"httpOnly":false,"name":"dpm","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":41,"value":"13416204905266713521596538407434047150"},{"domain":".crwdcntrl.net","expires":1655330760.5771401,"httpOnly":false,"name":"_cc_dc","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":7,"value":"1"},{"domain":".crwdcntrl.net","expires":1655330760.57726,"httpOnly":false,"name":"_cc_id","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":38,"value":"b5f776edac518b1b8ecdfb3450de3fb2"},{"domain":".tapad.com","expires":1637187459.6153281,"httpOnly":false,"name":"TapAd_3WAY_SYNCS","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":16,"value":""},{"domain":"www.textnow.com","expires":1634595479.8331521,"httpOnly":true,"name":"connect.sid","path":"","priority":"Medium","secure":true,"session":false,"size":91,"value":"s%3A0rdMv9DDIyjULnW0Z09Hu9Y09cxwn032.XM17NMRZvAqWhrw583jAdLJ1qOXthShWOVY75FBRXFw"},{"domain":".textnow.com","expires":1639779469,"httpOnly":false,"name":"_fbp","path":"","priority":"Medium","sameSite":"Lax","secure":false,"session":false,"size":30,"value":"fb.1.1632003468393.8541863"},{"domain":".facebook.com","expires":1639779468.5580499,"httpOnly":true,"name":"fr","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":41,"value":"0MLgkIFGSuYMLLm7P..BhRmWM...1.0.BhRmWM."},{"domain":".youtube.com","expires":-1,"httpOnly":true,"name":"YSC","path":"","priority":"Medium","sameSite":"None","secure":true,"session":true,"size":14,"value":"KvImMnESd8E"},{"domain":".youtube.com","expires":1647555469.6569459,"httpOnly":true,"name":"VISITOR_INFO1_LIVE","path":"","priority":"Medium","sameSite":"None","secure":true,"session":false,"size":29,"value":"iM1_F7Yr2H4"},{"domain":"www.textnow.com","expires":-1,"httpOnly":false,"name":"language","path":"","priority":"Medium","secure":false,"session":true,"size":10,"value":"be"},{"domain":".textnow.com","expires":1632003804,"httpOnly":false,"name":"_px3","path":"","priority":"Medium","sameSite":"Lax","secure":false,"session":false,"size":379,"value":"63f5ff4c4d356d9fe12a78f06dab830bd94954540ecb94d5bc5155462a51a364:9edZyvy3GLN1rfFQYdclBqEs+JjHH03sSIB83mztp4PsPvBMmLZ6dA1THB1mcXV7pNueVCywpEmNXffx4scDg==:1000:wDA9lXXEcMX49t4Hnh6zNmqHpyLA0sLu60KB0eTKtlh3TiypdJGtEfmz86p5aOAtgAbvbgefOjreEb8q845oHj8UcrYFpitupeSBzcQVgKxWkRfha+88qqJT2JfZlHHpXLULEjvpUOiLojrPw541Bky1c05BtNrhJAWL3orsWjjmRhskxsr+SY5kLjQy1OsYOwKFgIIJQcgW1Rk7b3Rw=="},{"domain":"www.textnow.com","expires":1632004382,"httpOnly":false,"name":"_dd_s","path":"","priority":"Medium","sameSite":"Strict","secure":false,"session":false,"size":31,"value":"rum=0&expire=1632004382388"},{"domain":"www.textnow.com","expires":1632089882,"httpOnly":false,"name":"puntCookie","path":"","priority":"Medium","secure":false,"session":false,"size":14,"value":"true"}]}',
    1,
    1000
    }
    box.space.proxy:insert{
    uuid.str(),
    'zproxy.lum-superproxy.io',
    '22225',
    'lum-customer-c_518000c3-zone-zone17-country-gb',
    'bag16222',
    1,
    '',
    '',
    1000
    }
    box.space.service:insert{
    1,
    1,
    '{"Expressions":[{"RegularExpression":"[0-9]{6}"},{"RegularExpression":"[0-9]{5}"},{"RegularExpression":"[0-9]{4}"}]}',
    'vk',
    1000
    }
    box.space.service:insert{
    2,
    1,
    '{"Expressions":[{"RegularExpression":"[0-9]{6}"},{"RegularExpression":"[0-9]{5}"},{"RegularExpression":"[0-9]{4}"}]}',
    'tg',
    1000
    }
    box.space.users:insert{
    uuid.str(),
    'test',
    1000,
    'testapikey',
    1000
    }
end

function CallReplica(JsonString)
    -- return vshard.router.callre()
    return _G[json.decode(JsonString).function_name](json.decode(JsonString).JsonData)
end

function CallMaster(JsonString)
    -- return vshard.router.callre()
    return _G[json.decode(JsonString).function_name](json.decode(JsonString).JsonData)
end