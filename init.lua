

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
