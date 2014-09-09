#!lua-5.2.3/src/lua

--
-- Test Gear Lua API
--

-- Include Test Gear lua module
require("testgear-lua")

-- Print version
print("testgearctl v0.2alpha\n")

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

    function self.load (name)
        print("Loading " .. name .. " plugin")
        -- Create plugin table
        self[name] = {}
        -- Watch plugin table events
        setmetatable(self[name], self)
        -- Populate plugin table with plugin vars/functions
        self[name].command = "touch bla.txt"
        self[name].run_command = function ()
            print("Running " .. self[name].command)
        end
    end

    print("Connecting to " .. hostname)

    return self
end
