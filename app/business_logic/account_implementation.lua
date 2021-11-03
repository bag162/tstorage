local json = require('json')

function GetAccountDataByFilter(JsonString)
    local filterLogin = json.decode(JsonString).login
    local filterStatus = json.decode(JsonString).status
    local filterNumber = json.decode(JsonString).number
    local accSpace = box.space.account;

    return accSpace.index.getAccounts:select({filterNumber, filterStatus, filterLogin}, {iterator = 'GE'})
end