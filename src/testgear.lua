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
    -- Metatable
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
    self._handle = tg_connect(hostname)

    function self.load (name)
        local status

        if (type(name) ~= "string") then
            print("Error: Plugin name must be a string")
            return -1
        end

        status = tg_load(_handle, name)
        if (status < 0) then
            print("Error: " .. tg_error())
            return -1
        end

        print("Loaded " .. name .. " plugin")

        -- Add property table
        self[name] = {}
        -- Watch property events
        setmetatable(self[name], self)

        -- Populate property table with plugin vars/functions
--        self[name].command = "touch bla.txt"
--        self[name].run_command = function ()
--            print("Running " .. self[name].command)
--        end
    end

    function self.unload (name)
        local status
        if (type(name) ~= "string") then
            print("Error: Plugin name must be a string")
            return -1
        end

        status = tg_unload(_handle, name)
        if (status < 0) then
            print("Error: " .. tg_error())
            return -1
        end

        -- Delete property table
        self[name] = nil

        print("Unloaded " .. name .. " plugin")
    end

    function self.list_plugins()
        local plugins
        plugins = tg_list_plugins(_handle)
        print("Available plugins: " .. plugins)
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
    collectgarbage() -- Remove if too heavy
end

function disconnect (handle)
    tg_disconnect(handle._handle)
    destroy(handle)
    print("Disconnected")
end
