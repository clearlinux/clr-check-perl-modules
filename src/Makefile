all: build

build: clr-check-perl-modules clr-check-perl-modules-motd

install: clr-check-perl-modules clr-check-perl-modules-motd
	install -D -m 755 --target-directory=${DESTDIR}/usr/bin $<

clr-check-perl-modules: clr-check-perl-modules.pl
	cp $< $@
	chmod 755 $@

clr-check-perl-modules-motd: clr-check-perl-modules-motd.sh
	cp $< $@
	chmod 755 $@

