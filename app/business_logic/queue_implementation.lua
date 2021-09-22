local json = require('json')

function GetTask(JsonString)
    local count = json.decode(JsonString).count_tasks
    local tasks = box.space.queue.index.priority:select({10}, {iterator = 'LT', limit = count})
    for i = 1, Array_length(tasks) do
        local task = tasks[i]
        box.space.queue:delete(task[1])
    end
    return tasks
end