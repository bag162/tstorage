local fiber = require('fiber')
local uuid = require('uuid')

function InsertCheckProxyTask()
    local queue = box.space.queue
    while true do
        if queue.index.type:count(2) == 0 then
            local insertedTuple = box.tuple.new(uuid.str(), 2, 'not', 6, 1000)
            queue:insert(insertedTuple)
        end
        fiber.sleep(60)
    end
end

function InsertCheckAccountTask()
    local queue = box.space.queue
    while true do
        if queue.index.type:count(5) == 0 then
            local insertedTuple = box.tuple.new(uuid.str(), 5, 'not', 6, 1000)
            queue:insert(insertedTuple)
        end
        fiber.sleep(60)
    end
end

function CheckCreateOrderTuplesTask()
    local queue = box.space.queue
    while true do
        if queue.index.type:count(3) == 0 then
            local insertedTuple = box.tuple.new(uuid.str(), 3, 'not', 6, 1000)
            queue:insert(insertedTuple)
        end
        fiber.sleep(60)
    end
end

function CheckDeleteOrderTuplesTask()
    local queue = box.space.queue
    while true do
        if queue.index.type:count(4) then
            local insertedTuple = box.tuple.new(uuid.str(), 4, 'not', 6, 1000)
            queue:insert(insertedTuple)
        end
        fiber.sleep(60)
    end
end