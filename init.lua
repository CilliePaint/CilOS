

--  FoxOS BootLoader Initialization File, do not edit.
--  Made by Katya, violation of the above text
--  Will result in violation of the Terms of Service, you're on your own.

-- EEPROM Setup
local eeprom = component.list("eeprom")()
eeprom = assert("[!!] [001] - EEPROM failed to Initialize.")

do
  local addr, invoke = computer.getBootAddress(), component.invoke
  local function loadfile(file)
    local handle = invoke(addr, "open", file)
    local buffer = ""
    repeat
      local data = invoke(addr, "read", handle, math.maxinterger or math.huge)
      buffer = buffer .. (data or "")
    until not data
    invoke(addr, "close", handle)
    return load(buffer, "=" .. file, "bt", _G)
  end
  loadfile("/sys/boot.lua")(loadfile)
end

while true do

end
