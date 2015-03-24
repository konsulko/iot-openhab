-- MQTT-based door sensor using a Reed switch

broker = "openhab"
port = 1883
keepalive = 120
username = ""
password = ""
clientid = "DOOR1"
topic = "/house/frontdoor"
gpio2 = 4

-- Door switch contact interrupt callback
function switchcb(level)
  if level == 1 then
    state = "CLOSED"
  else
    state = "OPEN"
  end

  -- Publish a message on each change in state
  tmr.alarm(2, 1000, 0, function() m:publish(topic, state, 0, 0, function(conn) print("sent") end) end)
end

-- Create an MQTT client instance and connect to the broker
m = mqtt.Client(clientid, keepalive, username, password)
m:connect(broker, port, 0, function(conn) print("connected") end)

-- Configure GPIO2 as an interrupt with a pullup
gpio.mode(gpio2, gpio.INT, gpio.PULLUP)
-- Set GPIO2 to call our handler on both edges
gpio.trig(gpio2, "both", switchcb)
