#!lua-5.2.3/src/lua -i

--
-- Test Gear test script
--

-- Include Test Gear API
require("testgear")

-- First test case (TODO):
--  device = connect("127.0.0.1")
--  device.load("shell")
--  device.shell.command = "touch bla.txt"
--  device.shell.command()
--  device.unload("shell")
--  disconnect(device)

device = connect("127.0.0.1")
device.load("shell")
print(device.shell.command)
device.shell.run_command()
