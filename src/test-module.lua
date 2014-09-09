#!lua-5.2.3/src/lua

--
-- Test Gear lua module test script
--

-- Include Test Gear API
require("testgear")


-- Connect to Test Gear device server
device = tg_connect("127.0.0.1")

-- Load shell plugin
result = tg_load(device, "shell")
print(result)

-- Query general plugin information
version = tg_get_string(device, "shell.version")
print("Plugin version: " .. version)

-- Unload shell plugin
result = tg_unload(device, "shell")
print(result)

-- Disconnect from Test Gear server
result = tg_disconnect(device)
print(result)
