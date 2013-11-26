#!/bin/bash
# bash scripting
#

#TG=testgear
TG=echo

# Test Gear wrapper functions
function connect () { $TG connect $@; }
function disconnect () { $TG disconnect $@; }
function status () { $TG status $@; }
function select () { $TG select $@; }
function load () { $TG load $@; }
function unload () { $TG unload $@; }
function get () { $TG get $@; }
function set () { $TG set $@; }
function run () { $TG run $@; }


# Run framebuffer test plugin test
connect 191.168.0.42 sitara
load fb
get fb.version
get fb.description
get fb.author
get fb.license
set fb.xres 1920
set fb.yres 1080
set fb.xoffset 0
set fb.yoffset 0
run fb.open
set fb.show.image "/images/test.png"
set fb.show.stretch "yes"
run fb.show
run fb.close
unload fb
