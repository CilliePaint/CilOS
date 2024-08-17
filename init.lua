

--  FoxOS BootLoader Initialization File, do not edit.
--  Made by Katya, violation of the above text
--  Will result in violation of the Terms of Service, you're on your own.


  -- Delcaring simplistic Variables, including the Global for Operating system version
_G._OSVERSION = "FoxOS BootLoader 0.0.1.0000"

-- EEPROM Setup
local eeprom = component.list("eeprom")()
eeprom = assert("[!!] [001] - EEPROM failed to Initialize.")

-- GPU Decleration.
local w, h
local screen = component.list("screen", true)()

local gpu = screen and component.list("gpu")()

-- GPU Proxy
if gpu then
  gpu = component.proxy(gpu)
  if not gpu.getScreen() then
    gpu.bind(screen)
  end
  _G.boot_screen = gpu.getScreen()
  w, h = gpu.maxResolution()
  gpu.setResolution(w, h)
  gpu.setBackground(0x000000)
  gpu.setForeground(0xdc8668)
  gpu.fill(1, 1, w, h, " ")
end

-- Setup for the status function.
local y = 1
local uptime = computer.uptime

local last_sleep = uptime()

-- Status Function.
local function status(msg)
  if gpu then
    gpu.set(1, y, msg)
    if y == h then
      gpu.copy(1, 2, w, h - 1, 0, -1)
      gpu.fill(1, h, w, 1, " ")
    else
      y = y + 1
    end
  end
end

do
  local addr, invoke = computer.getBootAddress(), component.invoke
  local function loadfile(file)
    status("[--] > " .. file)
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
