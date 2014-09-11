--
-- Test Gear test script
--

-- First test case (TODO):
--  device = connect("127.0.0.1")
--  device.load("shell")
--  device.shell.command = "touch bla.txt"
--  print(device.shell.command)
--  device.shell.run_command()
--  device.unload("shell")
--  disconnect(device)

device = connect("127.0.0.1")
device.load("shell")
device.unload("shell")
disconnect(device)
