-- init.lua
-- Configures WiFi and door sensor

dofile("wifi-cfg.lua")
tmr.alarm(1, 3000, 0, function() dofile("door-sensor.lua") end)
