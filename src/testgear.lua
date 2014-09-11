#!lua-5.2.3/src/lua

--
-- Test Gear Lua API
--

-- Include Test Gear lua module
require("testgear-lua")

-- Print version
print("testgearctl v0.2alpha\n")

-- Disable debug module
debug=nil

-- API functions

function connect (hostname)
    local self =
    {
        __index = function (t,k)
            print("read variable " .. k)
            return rawget(t,k)
        end,

        __newindex = function (t,k,v)
            rawset(t,k,v)
            print("wrote variable " .. k)
        end,

        __writeindex = function (t,k,v)
            rawset(t,k,v)
            print("wrote preexisting variable " .. k)
        end,

        __readindex = function (t,k)
            if (type(rawget(t,k)) ~= "function") then
                print("read preexisting variable " .. k)
            end
            return rawget(t,k)
        end,
    }

    print("Connected to " .. hostname)
    self.handle = tg_connect(hostname)
--    if ((self["con"] = tg_connect(hotname)) ~= OK) then
--        error("Could not connect")
--    end

    function self.load (name)
        print("Loaded " .. name .. " plugin")
        tg_load(handle, name)

        -- Create table for this plugin
        self[name] = {}
        -- Watch plugin table events
        setmetatable(self[name], self)

        -- Populate plugin table with plugin vars/functions
--        self[name].command = "touch bla.txt"
--        self[name].run_command = function ()
--            print("Running " .. self[name].command)
--        end
    end

    function self.unload (name)
        print("Unloaded " .. name .. " plugin")
        tg_unload(handle, name)
    end

    return self
end

local function destroy(table)
    local table_name

    assert(type(table)=="table", "Not a table")

    -- Find table in globals
    for key, value in pairs(_ENV) do
        if value == table then
            table_name = key
            break
        end
    end

    -- Destroy table
    _G[table_name] = nil
    collectgarbage()
end

function disconnect (handle)
    tg_disconnect(handle.handle)
    destroy(handle)
    print("Disconnected")
end
