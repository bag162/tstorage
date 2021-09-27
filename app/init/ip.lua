local socket = require "socket"

function GetCurrentIp()
    local client = socket.connect("www.google.com", 80)
    local ip, port = client:getsockname()
    return ip
end