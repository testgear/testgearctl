#!lua-5.2.3/install/bin/lua

--
-- Test Gear lua module test script
--

-- Include Test Gear API
require("testgear")


-- Connect to Test Gear device server
device = tg_connect("127.0.0.1")

-- List available plugins
plugins = tg_list_plugins(device)
print("Avaiable plugins: " .. plugins)

-- Load shell plugin
result = tg_load(device, "shell")
print(result)

-- List properties for plugin
properties = tg_plugin_list_properties(device, "shell")
print("Properties for shell: " .. properties)

-- Query general plugin information
version = tg_get_string(device, "shell.version")
print("Plugin version: " .. version)

-- Set command
tg_set_string(device, "shell.command", "touch blabla.txt")

-- Run command
result = tg_run(device, "shell.run")
print(result)

-- Unload shell plugin
result = tg_unload(device, "shell")
print(result)

-- Disconnect from Test Gear server
result = tg_disconnect(device)
print(result)
