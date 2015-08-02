$CC $CFLAGS shell.c sqlite3.c arm-ftruncate64.S arm-pread64.S arm-pwrite64.S a2_set_errno.c -DUSE_PREAD64 -DSQLITE_ENABLE_FTS3_BACKWARDS
