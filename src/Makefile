#
# testgearctl - Test Gear control application
#

VERSION=0.2alpha

CC=gcc
CFLAGS=-Wall -shared -fPIC -DVERSION=\"$(VERSION)\" -Wno-unused-variable -Wno-unused-function
INCLUDE=-I../../libtestgear/src/include -Ilua-5.2.3/install/include -Iinclude -Iluaprompt-0.4
#LIBS=-L../../libtestgear/src -Llua-5.2.3/install/lib/liblua.a ../../libtestgear/src/libtestgear.a
LIBS=lua-5.2.3/install/lib/liblua.a ../../libtestgear/src/libtestgear.a
PROMPT_FLAGS=-Wextra -Wno-unused-parameter -DHAVE_ASPRINTF -DHAVE_LIBREADLINE -DHAVE_READLINE_READLINE_H -DHAVE_READLINE_HISTORY -DHAVE_READLINE_HISTORY_H -D_GNU_SOURCE '-DHIDDEN_KEY_PREFIX="_"' -DALWAYS_APPEND_SUFFIXES

all: lua testgear-lua.so testgearctl

debug: CFLAGS += -DDEBUG -g
debug: all

objects = main.o \
          options.o \
          fileparser.o \
		  clock.o

$(objects): %.o: %.c
	$(CC) -c $(CFLAGS) $(INCLUDE) $< -o $@

testgearctl: $(objects) prompt.o
	$(CC) $(LDFLAGS) $(objects) prompt.o -o $@ -llua -Llua-5.2.3/install/lib -lm -ldl -lreadline -lhistory

lua:
	make -C lua-5.2.3 linux local MYCFLAGS="-fPIC"

prompt.o:
	$(CC) -c $(PROMPT_FLAGS) $(INCLUDE) luaprompt-0.4/prompt.c

testgear-lua.so: testgear-lua.c
	$(CC) $(CFLAGS) $(INCLUDE) $^ $(LIBS) -o $@

clean:
	rm -f *.so *.o
	make -C lua-5.2.3 clean

.PHONY: lua
