bin_PROGRAMS = testgearctl
dist_libexec_SCRIPTS = testgear-lua.so
testgearctl_SOURCES = clock.c fileparser.c main.c options.c
testgearctl_CFLAGS = -I $(srcdir)/lua-5.2.3/install/include -I $(srcdir)/luaprompt-0.4
testgearctl_LDADD = libprompt.a lua-5.2.3/install/lib/liblua.a -ltestgear -lm -ldl -lreadline -lhistory
noinst_LIBRARIES = libprompt.a
libprompt_a_SOURCES = luaprompt-0.4/prompt.c luaprompt-0.4/prompt.h
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

testgear-lua.so: testgear-lua.c
	$(CC) $(CFLAGS) -c -fPIC testgear-lua.c -I$(srcdir)/lua-5.2.3/install/include
	$(CC) $(LDFLAGS) -shared -fPIC testgear-lua.o $(srcdir)/lua-5.2.3/install/lib/liblua.a -lc -lm -ltestgear -o $@

bashcompletiondir=$(sysconfdir)/bash_completion.d
dist_bashcompletion_DATA=bash-completion/testgearctl
