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

#include <stdio.h>
#include <time.h>
#include "testgear/clock.h"
#include "testgear/colors.h"

static double time_start;
static double time_stop;

void clock_start(void)
{
   struct timespec start;

   /* Get start clock time */
   if( clock_gettime( CLOCK_MONOTONIC, &start) == -1 )
      printf("clock_gettime error\n");

   time_start = start.tv_sec + start.tv_nsec * 0.000000001;
}

void clock_stop(void)
{
   struct timespec stop;

   /* Get stop clock time */
   if( clock_gettime( CLOCK_MONOTONIC, &stop) == -1 )
      printf("clock_gettime error\n");

   time_stop = stop.tv_sec + stop.tv_nsec * 0.000000001;
}

void show_elapsed_time(void)
{
   double seconds = time_stop - time_start;
   int hours = seconds / 3600;
   int minutes = (seconds - hours * 3600) / 60;
   seconds = seconds - hours * 3600 - minutes * 60;

   printf(" Elapsed time: %2dh %2dm %2.0fs\n\n" ANSI_COLOR_RESET, hours, minutes, seconds);
}
