NAME1 = libtest1
NAME2 = libtest2

VERSION = 0.3

LIB1 = $(NAME1).so
LIB2 = $(NAME2).so.$(VERSION)

CC = gcc
INSTALL = install

PREFIX = $(DESTDIR)/usr
LIBDIR = $(PREFIX)/lib64
DATADIR = $(PREFIX)/share/test
DOCDIR = $(PREFIX)/share/doc/test

.PHONY: libs install clean

libs: $(LIB1) $(LIB2)

$(LIB1): $(NAME1).c
	$(CC) $(CFLAGS) $(LDFLAGS) -shared -fPIC -Wl,-soname,$@ -o $@ $<

$(LIB2): $(NAME2).c
	$(CC) $(CFLAGS) $(LDFLAGS) -shared -fPIC -Wl,-soname,$@ -o $@ $<

install: $(LIB1) $(LIB2)
	$(INSTALL) -D -t $(LIBDIR) $^
	$(INSTALL) -D -t $(DATADIR) data/*.dat
	$(INSTALL) -D -t $(DATADIR)/extra data/extra/*.dat

clean:
	rm -f $(LIB1) $(LIB2)
