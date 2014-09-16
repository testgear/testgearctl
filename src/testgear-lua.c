/*
 * Copyright (c) 2014, Martin Lund
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holders nor contributors may be
 *    used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT
 * HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#include <string.h>
#include "testgear/testgear.h"
#include "testgear/debug.h"

// lua: handle = tg_connect(name)
static int connect(lua_State *L)
{
    int cd;
    const char *name = lua_tostring(L, 1);
    debug_printf("Connecting to %s\n", name);

    // Connect to Test Gear server
    cd = tg_connect(name);

    // Return result
    lua_pushinteger(L, cd);
    return 1;
}

// lua: tg_disconnect(handle)
static int disconnect(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    debug_printf("Disconnecting...\n");

    // Disconnect from server
    result = tg_disconnect(cd);

    // Return result
    lua_pushnumber(L, result);
    return 1;
}

// lua: tg_load(handle, name)
static int load(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    debug_printf("Loading %s (%d)\n", name, cd);

    // Load Test Gear plugin
    result = tg_plugin_load(cd, name);

    // Return result
    lua_pushnumber(L, result);
    return 1;
}

// lua: tg_unload(handle, name)
static int unload(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    debug_printf("Unloading %s\n", name);

    // Unload Test Gear plugin
    result = tg_plugin_unload(cd, name);

    // Return result
    lua_pushnumber(L, result);
    return 1;
}

// lua: number = tg_get_char(handle, name)
static int get_char(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    char value;

    // Get char
    result = tg_get_char(cd, name, &value);
    if (result == 0)
    {
        // Return char result
        lua_pushnumber(L, value);
        return 1;
    }

    return 0;
}

// lua: tg_set_char(handle, name, value)
static int set_char(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    const char value = lua_tointeger(L, 3);

    // Set char
    result = tg_set_char(cd, name, value);

    if (result != 0)
        luaL_error(L, "tg_set_char() failed (%s)", tg_error);

    return 0;
}

// lua: number = tg_get_short(handle, name)
static int get_short(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    short value;

    // Get short
    result = tg_get_short(cd, name, &value);
    if (result == 0)
    {
        // Return short result
        lua_pushnumber(L, value);
        return 1;
    }

    return 0;
}

// lua: tg_set_short(handle, name, value)
static int set_short(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    const short value = lua_tointeger(L, 3);

    // Set short
    result = tg_set_short(cd, name, value);

    if (result != 0)
        luaL_error(L, "tg_set_short() failed (%s)", tg_error);

    return 0;
}

// lua: number = tg_get_int(handle, name)
static int get_int(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    int value;

    // Get int
    result = tg_get_int(cd, name, &value);
    if (result == 0)
    {
        // Return int result
        lua_pushnumber(L, value);
        return 1;
    }

    return 0;
}

// lua: tg_set_int(handle, name, value)
static int set_int(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    const int value = lua_tointeger(L, 3);

    // Set int
    result = tg_set_int(cd, name, value);

    if (result != 0)
        luaL_error(L, "tg_set_int() failed (%s)", tg_error);

    return 0;
}

// lua: number = tg_get_float(handle, name)
static int get_float(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    float value;

    // Get float
    result = tg_get_float(cd, name, &value);
    if (result == 0)
    {
        // Return float result
        lua_pushnumber(L, value);
        return 1;
    }

    return 0;
}

// lua: tg_set_float(handle, name, value)
static int set_float(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    const float value = lua_tonumber(L, 3);

    // Set float
    result = tg_set_float(cd, name, value);

    if (result != 0)
        luaL_error(L, "tg_set_float() failed (%s)", tg_error);

    return 0;
}

// lua: string = tg_get_string(handle, name)
static int get_string(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    char string[65536] = "";

    // Get string
    result = tg_get_string(cd, name, (char *) &string);

    if (result == 0)
    {
        // Return string result
        lua_pushstring(L, string);
        return 1;
    }
    return 0;
}

// lua: tg_set_string(handle, name, value)
static int set_string(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    const char *string = lua_tostring(L, 3);

    // Set string
    result = tg_set_string(cd, name, (char *) string);

    if (result != 0)
        luaL_error(L, "tg_set_string() failed (%s)", tg_error);

    return 0;
}

// lua: string = tg_list_plugins(handle)
static int list_plugins(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    char string[65536] = "";

    // Get string
    result = tg_list_plugins(cd, (char *) &string);

    if (result == 0)
    {
        // Return string result
        lua_pushstring(L, string);
        return 1;
    }
    return 0;
}

// lua: string = tg_plugin_list_properties(handle, name)
static int plugin_list_properties(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    char string[65536] = "";

    // Get string
    result = tg_plugin_list_properties(cd, name, (char *) &string);

    if (result == 0)
    {
        // Return string result
        lua_pushstring(L, string);
        return 1;
    }
    return 0;
}

// lua: string = tg_error()
static int error(lua_State *L)
{
    char error[256] = "Unknown error occured\n";

    if (strlen(tg_error) != 0)
        strcpy(error, tg_error);

    // Return error string
    lua_pushstring(L, error);

    return 1;
}

// lua: tg_run(handle, name)
static int run(lua_State *L)
{
    int result;
    int cd = lua_tointeger(L, 1);
    const char *name = lua_tostring(L, 2);
    debug_printf("Run %s\n", name);

    // Unload Test Gear plugin
    tg_run(cd, name, &result);

    // Return result
    lua_pushnumber(L, result);
    return 1;
}

int luaopen_testgear(lua_State *L)
{
    lua_register(L, "tg_connect", connect);
    lua_register(L, "tg_disconnect", disconnect);
    lua_register(L, "tg_list_plugins", list_plugins);
    lua_register(L, "tg_load", load);
    lua_register(L, "tg_unload", unload);
    lua_register(L, "tg_plugin_list_properties", plugin_list_properties);
    lua_register(L, "tg_get_char", get_char);
    lua_register(L, "tg_set_char", set_char);
    lua_register(L, "tg_get_short", get_short);
    lua_register(L, "tg_set_short", set_short);
    lua_register(L, "tg_get_int", get_int);
    lua_register(L, "tg_set_int", set_int);
    lua_register(L, "tg_get_float", get_float);
    lua_register(L, "tg_set_float", set_float);
    lua_register(L, "tg_get_string", get_string);
    lua_register(L, "tg_set_string", set_string);
    lua_register(L, "tg_run", run);
    lua_register(L, "tg_error", error);
    return 0;
}
