#!lua-5.2.3/src/lua

--
-- Test Gear lua test script
--

-- Include Test Gear API
require("testgear")

device=connect("192.168.0.1")
device.load("wifi")
print(device.wifi)
