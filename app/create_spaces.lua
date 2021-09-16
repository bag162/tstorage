local spaces = {}

function spaces.initUsersDB()	--in-memory
    local users_space = box.schema.space.create('users', {if_not_exists = true})
	users_space:format({
        {'primary_index', 'string'},
        {'login', 'string'},
        {'balance', 'NUMBER'},
        {'apikey', 'string'},
        {'bucket_id', 'NUMBER'},})
    users_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    users_space:create_index('login', {parts = {'login'}, unique = true})
    users_space:create_index('balance', {parts = {'balance'}, unique = false})
    users_space:create_index('apikey', {parts = {'apikey'}, unique = true})
    users_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function spaces.initOrdersDB()	--in-memory
	local orders_space = box.schema.space.create('orders', {if_not_exists = true})
	orders_space:format({
        {'primary_index', 'string'},
        {'status', 'NUMBER'},
        {'number', 'string'},
        {'userid', 'NUMBER'},
        {'orderid', 'string'},
        {'service', 'NUMBER'},
        {'sms', 'string'},
        {'sms_code', 'string'},
        {'start_time', 'string'},
        {'bucket_id', 'NUMBER'},})
    orders_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    orders_space:create_index('status', {parts = {'status'}, unique = false})
    orders_space:create_index('number', {parts = {'number'}, unique = false})
    orders_space:create_index('userid', {parts = {'userid'}, unique = false})
    orders_space:create_index('orderid', {parts = {'orderid'}, unique = false})
    orders_space:create_index('service', {parts = {'service'}, unique = false})
    orders_space:create_index('sms', {parts = {'sms'}, unique = false})
    orders_space:create_index('sms_code', {parts = {'sms_code'}, unique = false})
    orders_space:create_index('start_time', {parts = {'start_time'}, unique = false})
    orders_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function spaces.initHistoryDB()	--disk
	local history_space = box.schema.space.create('history', {if_not_exists = true, engine = 'vinyl'})
    history_space:format({
        {'primary_index', 'string'},
        {'typerequest', 'NUMBER'},
        {'userid', 'string'},
        {'datetime', 'string'},
        {'bucket_id', 'NUMBER'},})
    history_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    history_space:create_index('typerequest', {parts = {'typerequest'}, unique = false})
    history_space:create_index('userid', {parts = {'userid'}, unique = false})
    history_space:create_index('datetime', {parts = {'datetime'}, unique = false})
    history_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function spaces.initServicesDB()	--in-memory
	local service_space = box.schema.space.create('service', {if_not_exists = true})
    service_space:format({
        {'primary_index', 'NUMBER'},
        {'price', 'NUMBER'},
        {'parseregularexp', 'string'},
        {'serviceprefix', 'string'},
        {'bucket_id', 'NUMBER'},})
    service_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
	service_space:create_index('price', {parts = {'price'}, unique = false})
    service_space:create_index('parseregularexp', {parts = {'parseregularexp'}, unique = false})
    service_space:create_index('serviceprefix', {parts = {'serviceprefix'}, unique = true})
    service_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function spaces.initAccountsDB() --in-memory
    local account_space = box.schema.space.create('account', {if_not_exists = true})
    account_space:format({
        {'primary_index', 'string'},
        {'loginaccount', 'string'},
        {'passwordaccount', 'string'},
        {'number', 'string'},
        {'cookie', 'string'},
        {'status', 'NUMBER'},
        {'bucket_id', 'NUMBER'},})
    account_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    account_space:create_index('loginaccount', {parts = {'loginaccount'}, unique = true})
    account_space:create_index('passwordaccount', {parts = {'passwordaccount'}, unique = false})
    account_space:create_index('number', {parts = {'number'}, unique = false})
    account_space:create_index('cookie', {parts = {'cookie'}, unique = false})
    account_space:create_index('status', {parts = {'status'}, unique = false})
    account_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function spaces.initProxyDB()	--in-memory
	local proxy_space = box.schema.space.create('proxy', {if_not_exists = true})
	proxy_space:format({
        {'primary_index', 'string'},
        {'ip', 'string'},
        {'port', 'string'},
        {'login', 'string'},
        {'password', 'string'},
        {'status', 'NUMBER'},
        {'lastdatetimeactive', 'string'},
        {'externalip', 'string'},
        {'bucket_id', 'NUMBER'}})
    proxy_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    proxy_space:create_index('ip', {parts = {'ip'}, unique = false})
    proxy_space:create_index('port', {parts = {'port'}, unique = false})
    proxy_space:create_index('login', {parts = {'login'}, unique = false})
    proxy_space:create_index('password', {parts = {'password'}, unique = false})
    proxy_space:create_index('status', {parts = {'primary_istatusndex'}, unique = false})
    proxy_space:create_index('lastdatetimeactive', {parts = {'lastdatetimeactive'}, unique = false})
    proxy_space:create_index('externalip', {parts = {'externalip'}, unique = false})
    proxy_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function spaces.InitQueue()	--imemory
	local queue_space = box.schema.space.create('queue', {if_not_exists = true})
	queue_space:format({
        {'primary_index', 'string'},
        {'type', 'NUMBER'},
        {'data', 'string'},
        {'priority', 'NUMBER'},
        {'starttime', 'string'},
        {'laststart', 'string'},
        {'bucket_id', 'NUMBER'}})
    queue_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    queue_space:create_index('type', {parts = {'type'}, unique = false})
    queue_space:create_index('data', {parts = {'data'}, unique = false})
    queue_space:create_index('priority', {parts = {'priority'}, unique = false})
    queue_space:create_index('starttime', {parts = {'starttime'}, unique = false})
    queue_space:create_index('laststart', {parts = {'laststart'}, unique = false})
    queue_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

return spaces;