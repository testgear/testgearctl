#!/usr/bin/lua5.2

--
-- Test Gear lua test script
--

require("testgear")

-- Utility functions
printf = function(s,...)
            return io.write(s:format(...))
         end

-- Connect to Test Gear device server
device = tg_connect("127.0.0.1")

-- Load shell plugin
result = tg_load(device, "shell")
print(result)

-- Query general plugin information
version = tg_get_string(device, "shell.version")
printf("Module version: %s\n", version)

-- Unload shell plugin
result = tg_unload(device, "shell")
print(result)

-- Disconnect from Test Gear server
result = tg_disconnect(device)
print(result)
