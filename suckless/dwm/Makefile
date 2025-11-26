# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

.PHONY: all clean dist install uninstall

all: dwm

dwm: $(OBJ)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

clean:
	rm -f dwm $(OBJ) $(OBJ:.o=.d) dwm.c.orig config.h.orig

dist: clean
	rm -f dwm-$(VERSION).tar.gz
	mkdir -p dwm-$(VERSION)
	cp -R Makefile config.mk config.def.h LICENSE README dwm.c drw.c drw.h util.c util.h transient.c dwm.1 dwm-$(VERSION)
	tar -cf dwm-$(VERSION).tar dwm-$(VERSION)
	gzip dwm-$(VERSION).tar
	rm -rf dwm-$(VERSION)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dwm $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dwm
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < dwm.1 > $(DESTDIR)$(MANPREFIX)/man1/dwm.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/dwm.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwm\
		$(DESTDIR)$(MANPREFIX)/man1/dwm.1
