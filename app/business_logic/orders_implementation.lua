local json = require('json')

function GetNumber(JsonString)
    local service = json.decode(JsonString).service_id
    local orders = box.space.orders

    local order = orders.index.get_number:select({0, service}, {limit = 1})
    if #order == 0 then
        return nil
    end
    local ordetable = order[1]:totable()

    orders:update(ordetable[1], {{'=', 2, 9}})
    return order[1]
end