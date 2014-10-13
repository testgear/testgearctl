AC_PREREQ([2.68])
AC_INIT([testgearctl], [0.2], [], [testgearctl], [http://github.com/testgear/testgearctl])
AC_CONFIG_HEADERS([src/include/config.h])
AM_INIT_AUTOMAKE([1.11 foreign dist-xz no-dist-gzip -Wall -Werror subdir-objects])
AM_SILENT_RULES([yes])
AM_PROG_AR
AC_PROG_CC
AC_PROG_INSTALL
LT_INIT
AC_LANG([C])
AC_CHECK_LIB([testgear], [tg_connect], [], [AC_MSG_ERROR(libtestgear not found)])
AC_CHECK_LIB([dl], [dlopen], [], [AC_MSG_ERROR(libdl not found)])
AC_CHECK_LIB([m], [cos], [], [AC_MSG_ERROR(libm not found)])
AC_CHECK_LIB([history], [using_history], [], [AC_MSG_ERROR(libhistory not found)])
AC_CHECK_LIB([readline], [readline], [], [AC_MSG_ERROR(libreadline not found)])
AC_CHECK_HEADERS([readline/readline.h], [], [AC_MSG_ERROR(readline/readline.h (libreadline-dev) not found)])
AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([src/Makefile])
AC_CONFIG_FILES([man/Makefile])
AC_OUTPUT
