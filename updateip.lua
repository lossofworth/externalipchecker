ext_ip_file = "/extip/EXT_IP"

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

local request = require("http.request")
local status, stream = request.new_from_uri("http://api.ipify.org/"):go()
if status:get(":status") == "200" then
  local fileip = readall(ext_ip_file)
  print("IP on file: ", fileip)
  local result = stream:get_body_as_string()
  local newip = string.gsub(result, "%s+", "")
  print("IP from web: ", newip)
  if fileip ~= newip then
    write(ext_ip_file)
  end
else
    print("Failed to get external IP")
end
