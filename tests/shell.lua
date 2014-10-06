--
-- Shell test script
--

-- tg
device = connect("tcp://127.0.0.1:8000")
device.load("shell")
-- tg
device.shell.command = "touch bla.txt"
device.shell.run()
-- tg
device.unload("shell")
disconnect(device)
