/*
 * Copyright (c) 2012-2014, Martin Lund
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

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <stdbool.h>
#include "testgear/fileparser.h"
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
#include "prompt.h"

#define ANSI_COLOR_PASS      "\x1b[1;37;42m"
#define ANSI_COLOR_FAIL      "\x1b[1;37;41m"
#define ANSI_COLOR_LUA_ERROR "\x1b[1;37;43m"
#define ANSI_COLOR_LUA_CODE  "\x1b[36m"
#define ANSI_COLOR_TEST_CASE "\x1b[1;37m"
#define ANSI_COLOR_RESET     "\x1b[0m"

#define MAX_LINE_SIZE 4096
#define MAX_CHUNK_SIZE 40960

void process_chunk(lua_State *L, char *chunk, int total_count)
{
    char test[40];
    static int count = 0;

    count++;
    printf(ANSI_COLOR_TEST_CASE "\n== Test %d/%d ========================================\n\n" ANSI_COLOR_RESET, count, total_count);
    printf(ANSI_COLOR_LUA_CODE "%s" ANSI_COLOR_RESET, chunk);
    sprintf(test, "test %d", count);

    int status = luaL_loadbuffer(L, chunk, strlen(chunk), test) ||
        lua_pcall(L, 0, 0, 0);
    if (status > 0)
    {
        fprintf(stderr, ANSI_COLOR_RESET "%s\n", lua_tostring(L, -1));
        lua_pop(L, 1);  // pop error message from the stack
        printf("\n   " ANSI_COLOR_LUA_ERROR " LUA ERROR " ANSI_COLOR_RESET "\n");
    } else
    {
        lua_getglobal(L, "_reset_fail");
        lua_pcall(L, 0, 1, 0);
        int fail = lua_tonumber(L, -1);

        if (fail)
            printf("\n   " ANSI_COLOR_FAIL " FAIL " ANSI_COLOR_RESET "\n");
        else
            printf("\n   " ANSI_COLOR_PASS " PASS " ANSI_COLOR_RESET "\n");
    }

    // Clear chunk
    chunk[0] = 0;
}

int count_tests(FILE *file)
{
    char line[MAX_LINE_SIZE];
    int count = 0;

    while(fgets(line, MAX_LINE_SIZE, file) != NULL)
    { 
        // keep looping until NULL pointer (EOF)
        if (strncmp(line, "-- tg", 5))
        {
            // Regular line
        } else
        {
            // Test Gear (tg) line
            count++;
        }
    }

    rewind(file);

    return count;
}

int parse_file(char *filename, lua_State *L)
{
    char line[MAX_LINE_SIZE];
    char chunk[MAX_CHUNK_SIZE];
    FILE *file;
    bool new_chunk = false;
    bool first = true;
    int total_count = 0;

    (void) luaL_dofile(L, "testgear.lua");

    file = fopen(filename, "r"); 
    if(file == NULL)
    {
        printf("Error: can't open file.\n");
        exit(EXIT_FAILURE);
    }

    // Count number of tests in file
    total_count = count_tests(file);

    // Process file line by line
    while(fgets(line, MAX_LINE_SIZE, file) != NULL)
    { 
        // keep looping until NULL pointer (EOF)
        if (strncmp(line, "-- tg", 5))
        {
            // Regular line

            // Add line to chunk
            strcat(chunk, line);
        } else
        {
            // Test Gear (tg) line

            if (first && (strlen(chunk) > 0))
                chunk[0]=0;

            // Process chunk
            if (strlen(chunk) > 0)
                process_chunk(L, chunk, total_count);

            first=false;
        }
    }

    // Process last chunk
    if (strlen(chunk) > 0)
        process_chunk(L, chunk, total_count);

    fclose(file);

    printf("\n");

    return 0;
}
