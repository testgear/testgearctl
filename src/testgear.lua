#!lua-5.2.3/src/lua

--
-- Test Gear Lua API
--

-- Include Test Gear lua module
require("testgear-lua")

-- API functions

function connect (hostname)
    local self = 
    {
            __index = function (t,k)
                print("read variable")
                return rawget(t,k)
            end,

            __newindex = function (t,k,v)
                rawset(t,k,v)
                print("wrote variable")
            end,

            __writeindex = function (t,k,v)
                rawset(t,k,v)
                print("wrote preexisting variable")
            end,

            __readindex = function (t,k)
                print("read preexisting variable")
                return rawget(t,k)
            end,
    }

    function self.load (name)
        print("Loading " .. name)
        self[name]=42
    end

    print("Connecting to " .. hostname)

    setmetatable(self, self)

    return self
end
