bin_PROGRAMS = testgearctl

pkglib_LTLIBRARIES = testgearlua.la
testgearlua_la_SOURCES = testgearlua.c
testgearlua_la_CFLAGS = -I$(srcdir)/lua-5.2.3/install/include
testgearlua_la_LDFLAGS = -module -avoid-version -shared -export-dynamic $(srcdir)/lua-5.2.3/install/lib/liblua.a -lc -lm

pkgdata_DATA = testgear.lua

testgearctl_SOURCES = clock.c \
                      fileparser.c \
                      main.c \
                      options.c \
                      include/testgear/debug.h \
                      include/testgear/options.h \
                      include/testgear/colors.h \
                      include/testgear/clock.h \
                      include/testgear/fileparser.h \
                      lua-5.2.3/src/Makefile \
                      lua-5.2.3/src/*.[ch] \
                      lua-5.2.3/src/*.hpp \
                      lua-5.2.3/Makefile \
                      lua-5.2.3/doc/*.1 \
                      testgear.lua.in

testgearctl_CFLAGS = -I $(srcdir)/lua-5.2.3/install/include -I $(srcdir)/luaprompt-0.4 -DDATADIR=\"$(pkgdatadir)\"
testgearctl_LDADD = libprompt.a lua-5.2.3/install/lib/liblua.a -ltestgear -lm -ldl -lreadline -lhistory
noinst_LIBRARIES = libprompt.a
libprompt_a_SOURCES = luaprompt-0.4/prompt.c \
                      luaprompt-0.4/prompt.h
libprompt_a_CFLAGS = -Wextra \
                     -Wno-unused-parameter \
                     -DHAVE_ASPRINTF \
                     -DHAVE_LIBREADLINE \
                     -DHAVE_READLINE_READLINE_H \
                     -DHAVE_READLINE_HISTORY \
                     -DHAVE_READLINE_HISTORY_H \
                     -D_GNU_SOURCE '-DHIDDEN_KEY_PREFIX="_"' \
                     -DALWAYS_APPEND_SUFFIXES \
                     -I $(srcdir)/lua-5.2.3/install/include

do_subst = sed -e 's,[@]pkglibdir[@],$(pkglibdir),g'
testgear.lua: testgear.lua.in
	$(do_subst) < $(srcdir)/testgear.lua.in > testgear.lua
	chmod +x testgear.lua

bashcompletiondir=$(sysconfdir)/bash_completion.d
dist_bashcompletion_DATA=bash-completion/testgearctl
