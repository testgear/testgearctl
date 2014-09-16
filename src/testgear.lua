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
            if (k ~= "_type") and (k ~= "_name") and (k ~= "_parent") then
                local handle = t._parent._handle
                local name = t._name .. "." .. k
                local var_type = t._type[k]

                if (type(rawget(t,k)) == "function") then
--                    print("wrote preexisting function " .. k)
                else
--                    print("wrote preexisting variable " .. k)
                    if (var_type == "char") then
                        tg_set_char(handle, name, v)
                    elseif (var_type == "short") then
                        tg_set_short(handle, name, v)
                    elseif (var_type == "int") then
                        tg_set_int(handle, name, v)
                    elseif (var_type == "float") then
                        tg_set_float(handle, name, v)
                    elseif (var_type == "string") then
                        tg_set_string(handle, name, v)
                    end
                end
            end
--            rawset(t,k,v)
        end,

        __readindex = function (t,k)
            local result = 0
            if (k ~= "_type") and (k ~= "_name") and (k ~= "_parent") then
                local handle = t._parent._handle
                local name = t._name .. "." .. k
                local var_type = t._type[k]

                if (type(rawget(t,k)) == "function") then
--                    print("read preexisting function " .. k)
                    result = tg_run(handle, name)
--                    print(result)
--                    return result
                else
--                    print("read preexisting variable " .. k)
                    if (var_type == "char") then
                        return (tg_get_char(handle, name))
                    elseif (var_type == "short") then
                        return (tg_get_short(handle, name))
                    elseif (var_type == "int") then
                        return (tg_get_int(handle, name))
                    elseif (var_type == "float") then
                        return (tg_get_float(handle, name))
                    elseif (var_type == "string") then
                        return (tg_get_string(handle, name))
                    end
                end
            end
            return rawget(t,k)
        end
    }

    print("Connected to " .. hostname)
    self._handle = tg_connect(hostname)

    function self.load (name)
        local status
        local properties

        function string:split(sep)
            local sep, fields = sep or ":", {}
            local pattern = string.format("([^%s]+)", sep)
            self:gsub(pattern, function(c) fields[#fields+1] = c end)
            return fields
        end

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

        -- Add type lookup table
        self[name]._type = {}

        -- Save parent
        self[name]._parent = self

        -- Save name of table
        self[name]._name = name

        -- Populate property table with plugin vars/functions
        properties = tg_plugin_list_properties(self._handle, name)
        local property = properties:split(",")
        for i = 1, #property do
            word = property[i]:split(":")
            if (word[2] == "0") then
                self[name][word[1]] = 0
                self[name]._type[word[1]] = "char"
            elseif (word[2] == "1") then
                self[name][word[1]] = 0
                self[name]._type[word[1]] = "short"
            elseif (word[2] == "2") then
                self[name][word[1]] = 0
                self[name]._type[word[1]] = "int"
            elseif (word[2] == "3") then
                self[name][word[1]] = 0
                self[name]._type[word[1]] = "float"
            elseif (word[2] == "4") then
                self[name][word[1]] = ""
                self[name]._type[word[1]] = "string"
            elseif (word[2] == "5") then
                self[name][word[1]] = ""
                self[name]._type[word[1]] = "data"
            elseif (word[2] == "6") then
                self[name][word[1]] = function () end
                self[name]._type[word[1]] = "command"
            end
        end

        -- Watch property events
        setmetatable(self[name], self)
    end

    function self.unload (name)
        local status
        if (type(name) ~= "string") then
            print("Error: Plugin name must be a string")
            return -1
        end

        status = tg_unload(self._handle, name)
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
        plugins = tg_list_plugins(self._handle)
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
