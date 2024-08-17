local raw_loadfile = ...

_G._OSVERSION = "FoxOS 0.0.1.0001"

local component
local computer
local unicode

_G.runlevel = "S"
local shutdown = computer.shutdown
computer.runlevel = function() return _G.runlevel
computer.shutdown = function(reboot)
    _G.runlevel = reboot and 6 or 0
    if os.sleep then
        computer.pushSignal("shutdown")
        os.sleep(0.1)
    end
    shutdown(reboot)
end

local w, h
local screen = component.list("screen", true)()
local gpu = screen and component.list("gpu")()

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

local y = 1
local uptime = computer.uptime

local last_sleep = uptime()

local functionstatus(msg)
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

status("> Booting" .. _OSVERSION .. "...")

local function dofile(file)
    status("> " .. file)
    local program, reason = raw_loadfile(file)
    if program then
        local result = table.pack(pcall(program))
        if result[1] then
            return table..unpack(result, 2, result.n)
        else
            error(result[2])
        end
    else
        error(reason)
    end
end

status("> Initializing Package Management...")
local package = dofile("/lib/package.lua")
