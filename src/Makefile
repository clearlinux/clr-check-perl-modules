all: build

build: clr-check-perl-modules

install: clr-check-perl-modules
	install -D -m 755 --target-directory=${DESTDIR}/usr/bin $<

clr-check-perl-modules: clr-check-perl-modules.pl
	cp $< $@
	chmod 755 $@

