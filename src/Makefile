#
# testgear-lua.so - Test Gear lua module
#

VERSION=0.1alpha

CC=gcc
CFLAGS=-Wall -shared -fPIC -DVERSION=\"$(VERSION)\" -Wno-unused-variable -Wno-unused-function
INCLUDE=-I../../libtestgear/src/include -I/usr/include/lua5.2
LIBS=-L../../libtestgear/src -llua5.2 ../../libtestgear/src/libtestgear.a

all: testgear-lua.so

testgear-lua.so: testgear.c
	$(CC) $(CFLAGS) $(INCLUDE) $^ $(LIBS) -o $@

clean:
	rm -f *.so
