--
-- Test Gear test script
--

-- To run test script simply do:
-- ./testgearctl --interactive ./test.lua
--

-- tg
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
    device.dummy.long0 = 4242424242
    print(device.dummy.long0)
    device.dummy.float0 = 42.424242
    print(device.dummy.float0)
    device.dummy.double0 = 42.4242424242
    print(device.dummy.double0)
    device.dummy.string0 = "Hello world!"
    print(device.dummy.string0)
    device.dummy.command0()
--    device.unload("dummy")
--    disconnect(device)
end

if (device.dummy.char0 < 100) then fail() end

-- tg
--device = connect("127.0.0.1")
--device.load("dummy")

print("SPAM!")

--device.unload("dummy")
--disconnect(device)

-- tg
-- Force a lua error
- Fail me!

-- tg

print("The end")
