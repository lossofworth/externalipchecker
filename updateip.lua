global ext_ip_file = '/extip/EXT_IP'

function readall(filename)
  local fh = assert(io.open(filename, "rb"))
  local contents = assert(fh:read(_VERSION <= "Lua 5.2" and "*a" or "a"))
  fh:close()
  return contents
end

function write(filename, contents)
  local fh = assert(io.open(filename, "wb"))
  fh:write(contents)
  fh:flush()
  fh:close()
end

-- local url = require "socket.url"
local http = require "socket.http"
local result, status = http.request("http://api.ipify.org/")
if status == "200" then
    print(result, status)
    fileip = readall(ext_ip_file)
    newip = string.gsub(result, "%s+", "")
    if fileip ~= newip then
        write(ext_ip_file)
    end
else
    print("Failed to get external IP")
end
