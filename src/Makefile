#
# testgearctl - Test Gear control application
#

VERSION=0.2alpha

CC=gcc
CFLAGS=-Wall -shared -fPIC -DVERSION=\"$(VERSION)\" -Wno-unused-variable -Wno-unused-function
INCLUDE=-I../../libtestgear/src/include -Ilua-5.2.3/install/include -Iinclude
LIBS=-L../../libtestgear/src -Llua-5.2.3/install/lib/liblua.a ../../libtestgear/src/libtestgear.a

all: lua testgear-lua.so testgearctl

debug: CFLAGS += -DDEBUG -g
debug: all

objects = main.o \
          options.o

$(objects): %.o: %.c
	$(CC) -c $(CFLAGS) $(INCLUDE) $< -o $@

testgearctl: $(objects)
	$(CC) $(LDFLAGS) $(objects) -o $@

lua:
	make -C lua-5.2.3 linux local

testgear-lua.so: testgear-lua.c
	$(CC) $(CFLAGS) $(INCLUDE) $^ $(LIBS) -o $@

clean:
	rm -f *.so
	make -C lua-5.2.3 clean

.PHONY: lua
