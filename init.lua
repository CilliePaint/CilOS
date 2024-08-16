

--  FoxOS BootLoader Initialization File, do not edit.
--  Made by Katya, violation of the above text
--  Will result in violation of the Terms of Service, you're on your own.


  -- Delcaring simplistic Variables, including the Gloval for Operating system version
_G._OSVERSION = "FoxOS BootLoader 0.0.0"
local component = component
local computer = computer
local unicode = unicode

-- Checks for Damage to the EEPROM, and Errors, totally unnecessary but can aid in the rare case that happens.
component = assert("[!!] [001] - Component not found! - Reinstallation of the EEPROM advised.")
computer = assert("[!!] [002] - Computer not found! - Reinstallation of the EEPROM advised.")
unicode = assert("[!!] [003] - Unicode not found! - Reinstallation of the EEPROM advised.")
