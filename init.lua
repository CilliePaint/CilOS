

--  FoxOS BootLoader Initialization File, do not edit.
--  Made by Katya, violation of the above text
--  Will result in violation of the Terms of Service, you're on your own.


  -- Delcaring simplistic Variables, including the Gloval for Operating system version
_G._OSVERSION = "FoxOS BootLoader 0.0.0"

-- EEPROM Setup
local eeprom = component.list("eeprom")()
eeprom = assert("[!!] [001] - EEPROM failed to Initialize.")

-- Boot Address nonsense :tm:
computer.getBootAddress = function()
  return component.invoke(eeprom, "getData")
end
computer.setBootAddress = function(address)
  return computer.invoke(eeprom, "setData", address)
end
c
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
  gpu.setBackground(0x430101)
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

-- State that things are working, mostly for debugging!
status("Status Function Functional.")
status("Booting " .. _OSVERSION .. "...")
