local spaces = {}

function spaces.initUsersDB()	--in-memory
    local users_space = box.schema.space.create('users', {
        if_not_exists = true
    })
	
    users_space:create_index('primary_index', {
        if_not_exists = true,
        type = 'TREE',
        unique = true,
        parts = {1, 'string'}
    })

    users_space:create_index('secondary_login', {
        if_not_exists = true,
        type = 'TREE',
        unique = true,
        parts = {2, 'STRING'}
    })

    users_space:create_index('secondary_balance', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {3, 'INT'}
    })
	
	users_space:create_index('secondary_apikey', {
        if_not_exists = true,
        type = 'TREE',
        unique = true,
        parts = {4, 'STRING'}
    })

    users_space:create_index('bucket_id', {
        parts = {5, 'unsigned'}
    })
end

function spaces.initOrdersDB()	--in-memory
	local orders_space = box.schema.space.create('orders', {
        if_not_exists = true
    })
	
    orders_space:create_index('primary_index', {
        if_not_exists = true,
        type = 'TREE',
        unique = true,
        parts = {1, 'string'}
    })

    orders_space:create_index('secondary_status', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {2, 'INT'}
    })

    orders_space:create_index('secondary_number', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {3, 'STRING'}
    })
	
	orders_space:create_index('secondary_userid', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {4, 'STRING'}
    })
	
	orders_space:create_index('secondary_orderid', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {5, 'INT'}
    })
	
	orders_space:create_index('secondary_service', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {6, 'INT'}
    })
	
	orders_space:create_index('secondary_sms', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {7, 'STRING'}
    })
	
	orders_space:create_index('secondary_sms_code', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {8, 'STRING'}
    })
	
	orders_space:create_index('secondary_start_time', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {9, 'STRING'}
    })

    orders_space:create_index('bucket_id', {
        parts = {10, 'unsigned'}
    })
end

function spaces.initHistoryDB()	--disk
	local history_space = box.schema.space.create('history', {
        if_not_exists = true,
		engine = 'vinyl'
    })
	
	history_space:create_index('primary_index', {
        if_not_exists = true,
        type = 'TREE',
        unique = true,
        parts = {1, 'string'}
    })
	
	history_space:create_index('secondary_typerequest', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {2, 'INT'}
    })
	
	history_space:create_index('secondary_userid', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {3, 'string'}
    })
	
	history_space:create_index('secondary_datetime', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {4, 'string'}
    })
	
	history_space:create_index('bucket_id', {
        parts = {5, 'unsigned'}
    })
end

function spaces.initServicesDB()	--in-memory
	local service_space = box.schema.space.create('service', {
        if_not_exists = true
    })
	
    service_space:format({
        {'primary_index', 'NUMBER'},
        {'secondary_price', 'NUMBER'},
        {'secondary_parseregularexp', 'NUMBER'},
        {'secondary_serviceprefix', 'string'},
        {'bucket_id', 'string'},
    })

    service_space:create_index('primary_index', {parts = {'primary_index'}, unique = true})
	service_space:create_index('secondary_price', {parts = {'secondary_price'}, unique = false})
    service_space:create_index('secondary_parseregularexp', {parts = {'secondary_parseregularexp'}, unique = false})
    service_space:create_index('secondary_serviceprefix', {parts = {'secondary_serviceprefix'}, unique = true})
    service_space:create_index('bucket_id', {parts = {'bucket_id'}, unique = false})
end

function spaces.initAccountsDB() --in-memory
    local account_space = box.schema.space.create('account', {
        if_not_exists = true
    })
	
	account_space:create_index('primary_index', {
        if_not_exists = true,
        type = 'TREE',
        unique = true,
        parts = {1, 'string'}
    })

    account_space:create_index('secondary_loginaccount', {
        if_not_exists = true,
        type = 'TREE',
        unique = true,
        parts = {2, 'string'}
    })

    account_space:create_index('secondary_passwordaccount', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {3, 'string'}
    })

    account_space:create_index('secondary_number', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {4, 'string'}
    })

    account_space:create_index('secondary_cookie', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {5, 'string'}
    })

    account_space:create_index('secondary_status', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {6, 'INT'}
    })

    account_space:create_index('bucket_id', {
        parts = {7, 'unsigned'}
    })
end

function spaces.initProxyDB()	--in-memory
	local proxy_space = box.schema.space.create('proxy', {
        if_not_exists = true
    })
	
	proxy_space:create_index('primary_index', {
        if_not_exists = true,
        type = 'TREE',
        unique = true,
        parts = {1, 'string'}
    })
	
	proxy_space:create_index('secondary_ip', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {2, 'string'}
    })

    proxy_space:create_index('secondary_port', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {3, 'string'}
    })

    proxy_space:create_index('secondary_login', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {4, 'string'}
    })

    proxy_space:create_index('secondary_password', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {5, 'string'}
    })

    proxy_space:create_index('secondary_status', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {6, 'INT'}
    })

    proxy_space:create_index('secondary_lastdatetimeactive', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {7, 'string'}
    })

    proxy_space:create_index('secondary_externalip', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {8, 'string'}
    })

    proxy_space:create_index('bucket_id', {
        parts = {9, 'unsigned'}
    })
end

function spaces.InitQueue()	--imemory
	local queue_space = box.schema.space.create('queue', {
        if_not_exists = true
    })
	
	queue_space:create_index('primary_index', {
        if_not_exists = true,
        type = 'TREE',
        unique = true,
        parts = {1, 'string'}
    })
	
	queue_space:create_index('secondary_type', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {2, 'INT'}
    })
	
	queue_space:create_index('secondary_data', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {3, 'string'}
    })

    queue_space:create_index('secondary_priority', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {4, 'INT'}
    })

    queue_space:create_index('secondary_starttime', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {5, 'string'}
    })

    queue_space:create_index('secondary_laststart', {
        if_not_exists = true,
        type = 'TREE',
        unique = false,
        parts = {6, 'string'}
    })

	queue_space:create_index('bucket_id', {
        parts = {7, 'unsigned'}
    })

end

return spaces;