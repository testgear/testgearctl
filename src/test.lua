--
-- Test Gear test script
--

-- To run test script simply do:
-- ./testgearctl --interactive ./test.lua
--

-- First test case (TODO):
-- device = connect("127.0.0.1")
-- device.load("dummy")
-- device.dummy.string0 = "Hello world!"
-- device.dummy.command0()
-- device.unload("dummy")
-- disconnect(device)

device = connect("127.0.0.1")
device.load("dummy")

--device.unload("dummy")
--disconnect(device)
