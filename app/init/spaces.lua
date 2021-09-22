function InitUsersDB()	--in-memory
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

function InitOrdersDB()	--in-memory
	local orders_space = box.schema.space.create('orders', {if_not_exists = true})
	orders_space:format({
        {'primary_index', 'string'},
        {'status', 'NUMBER'},
        {'number', 'string'},
        {'user_id', 'string'},
        {'order_id', 'number'},
        {'service', 'NUMBER'},
        {'sms', 'string'},
        {'sms_code', 'string'},
        {'start_time', 'string'},
        {'last_check_time', 'string'},
        {'json_data', 'string'},
        {'bucket_id', 'NUMBER'},})
    orders_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    orders_space:create_index('status', {parts = {'status'}, unique = false})
    orders_space:create_index('number', {parts = {'number'}, unique = false})
    orders_space:create_index('user_id', {parts = {'user_id'}, unique = false})
    orders_space:create_index('order_id', {parts = {'order_id'}, unique = false})
    orders_space:create_index('service', {parts = {'service'}, unique = false})
    orders_space:create_index('sms', {parts = {'sms'}, unique = false})
    orders_space:create_index('sms_code', {parts = {'sms_code'}, unique = false})
    orders_space:create_index('start_time', {parts = {'start_time'}, unique = false})
    orders_space:create_index('last_check_time', {parts = {'last_check_time'}, unique = false})
    orders_space:create_index('json_data', {parts = {'json_data'}, unique = false})
    orders_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
    orders_space:create_index('get_number', {type = 'tree', parts = {{field = 2, type = 'number'}, {field = 6, type = 'number'}}, unique = false})
end

function InitHistoryDB()	--vinyl
	local history_space = box.schema.space.create('history', {if_not_exists = true, engine = 'vinyl'})
    history_space:format({
        {'primary_index', 'string'},
        {'type_request', 'NUMBER'},
        {'user_id', 'string'},
        {'date_time', 'string'},
        {'message', 'string'},
        {'bucket_id', 'NUMBER'},})
    history_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    history_space:create_index('type_request', {parts = {'type_request'}, unique = false})
    history_space:create_index('user_id', {parts = {'user_id'}, unique = false})
    history_space:create_index('date_time', {parts = {'date_time'}, unique = false})
    history_space:create_index('message', {parts = {'message'}, unique = false})
    history_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function InitServicesDB()	--in-memory
	local service_space = box.schema.space.create('service', {if_not_exists = true})
    service_space:format({
        {'primary_index', 'NUMBER'},
        {'price', 'NUMBER'},
        {'parse_regular_exp', 'string'},
        {'service_prefix', 'string'},
        {'bucket_id', 'NUMBER'},})
    service_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
	service_space:create_index('price', {parts = {'price'}, unique = false})
    service_space:create_index('parse_regular_exp', {parts = {'parse_regular_exp'}, unique = false})
    service_space:create_index('service_prefix', {parts = {'service_prefix'}, unique = true})
    service_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function InitAccountsDB() --vinyl
    local account_space = box.schema.space.create('account', {if_not_exists = true, engine = 'vinyl'})
    account_space:format({
        {'primary_index', 'string'},
        {'login', 'string'},
        {'password', 'string'},
        {'number', 'string'},
        {'cookie', 'string'},
        {'status', 'NUMBER'},
        {'bucket_id', 'NUMBER'},})
    account_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    account_space:create_index('login', {parts = {'login'}, unique = true})
    account_space:create_index('password', {parts = {'password'}, unique = false})
    account_space:create_index('number', {parts = {'number'}, unique = false})
    account_space:create_index('cookie', {parts = {'cookie'}, unique = false})
    account_space:create_index('status', {parts = {'status'}, unique = false})
    account_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function InitProxyDB()	--in-memory
	local proxy_space = box.schema.space.create('proxy', {if_not_exists = true})
	proxy_space:format({
        {'primary_index', 'string'},
        {'ip', 'string'},
        {'port', 'string'},
        {'login', 'string'},
        {'password', 'string'},
        {'status', 'NUMBER'},
        {'last_date_time_active', 'string'},
        {'external_ip', 'string'},
        {'bucket_id', 'NUMBER'}})
    proxy_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    proxy_space:create_index('ip', {parts = {'ip'}, unique = false})
    proxy_space:create_index('port', {parts = {'port'}, unique = false})
    proxy_space:create_index('login', {parts = {'login'}, unique = false})
    proxy_space:create_index('password', {parts = {'password'}, unique = false})
    proxy_space:create_index('status', {parts = {'status'}, unique = false})
    proxy_space:create_index('last_date_time_active', {parts = {'last_date_time_active'}, unique = false})
    proxy_space:create_index('external_ip', {parts = {'external_ip'}, unique = false})
    proxy_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function InitQueue()	--imemory
	local queue_space = box.schema.space.create('queue', {if_not_exists = true})
	queue_space:format({
        {'primary_index', 'string'},
        {'type', 'NUMBER'},
        {'data', 'string'},
        {'priority', 'NUMBER'},
        {'bucket_id', 'NUMBER'}})
    queue_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
    queue_space:create_index('type', {parts = {'type'}, unique = false})
    queue_space:create_index('data', {parts = {'data'}, unique = false})
    queue_space:create_index('priority', {parts = {'priority'}, unique = false})
    queue_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end