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

-- Load dummy plugin
result = tg_load(device, "dummy")
print(result)


-- List properties for plugin
properties = tg_plugin_list_properties(device, "dummy")
print("Plugin properties: " .. properties)

-- Query general plugin information
version = tg_get_string(device, "dummy.version")
print("Plugin version: " .. version)

-- Set char
tg_set_char(device, "dummy.char0", 42)

-- Get char
char0 = tg_get_char(device, "dummy.char0")
print("char0 = " .. char0)

-- Set short
tg_set_short(device, "dummy.short0", 4242)

-- Get short
short0 = tg_get_short(device, "dummy.short0")
print("short0 = " .. short0)

-- Set int
tg_set_int(device, "dummy.int0", 424242)

-- Get int
int0 = tg_get_int(device, "dummy.int0")
print("int0 = " .. int0)

-- Set long
tg_set_long(device, "dummy.long0", 4242424242)

-- Get long
long0 = tg_get_long(device, "dummy.long0")
print("long0 = " .. long0)

-- Set float
tg_set_float(device, "dummy.float0", 42.42)

-- Get float
float0 = tg_get_float(device, "dummy.float0")
print("float0 = " .. float0)

-- Set double
tg_set_double(device, "dummy.double0", 42.4242424242)

-- Get double
double0 = tg_get_double(device, "dummy.double0")
print("double0 = " .. double0)

-- Set string
tg_set_string(device, "dummy.string0", "Hello world!")

-- Get string
string0 = tg_get_string(device, "dummy.string0")
print("string0 = " .. string0)

-- Run command
result = tg_run(device, "dummy.command0")
print(result)


-- Unload dummy plugin
result = tg_unload(device, "dummy")
print(result)

-- Disconnect from Test Gear server
result = tg_disconnect(device)
print(result)
