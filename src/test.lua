--
-- Test Gear test script
--

-- To run test script simply do:
-- ./testgearctl --interactive ./test.lua
--

-- Dummy test case
if (true) then
    device = connect("127.0.0.1")
    device.list_plugins()
    device.load("dummy")
    device.dummy.char0 = 42
    print(device.dummy.char0)
    device.dummy.short0 = 4242
    print(device.dummy.short0)
    device.dummy.int0 = 424242
    print(device.dummy.int0)
    device.dummy.float0 = 42.42
    print(device.dummy.float0)
    device.dummy.string0 = "Hello world!"
    print(device.dummy.string0)
    device.dummy.command0()
    device.unload("dummy")
    disconnect(device)
end

--device = connect("127.0.0.1")
--device.load("dummy")

--device.unload("dummy")
--disconnect(device)
