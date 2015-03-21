-- Wifi configuration
-- FIXME: This should use timers to reconnect

ssid = "SSID"
password = "PASSPHRASE"

print("Configuring WiFi")

wifi.setmode(wifi.STATION)
wifi.sta.config(ssid, password)

tmr.alarm(0, 2000, 0, function() print("Connected with IP Address: " .. wifi.sta.getip()) end)
