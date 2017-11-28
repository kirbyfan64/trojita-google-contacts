PREFIX=/usr

FILE=trojita-google-contacts.pl
DEST=$(PREFIX)/bin/trojita-google-contacts
SYNC=1d

install:
	install -m 755 $(FILE) $(DEST)

install-link:
	ln -sf $$PWD/$(FILE) $(DEST); chmod +x $(DEST)

install-systemd:
	@if [ "`id -u`" = "0" ]; then echo "This should not be run as root!"; false; fi
	cd systemd; find * -exec install -Dm 644 {} ~/.config/systemd/user/{} \;
	sed -i 's!@prefix!$(PREFIX)!' ~/.config/systemd/user/trojita-google-contacts.service
	sed -i 's!@sync!$(SYNC)!' ~/.config/systemd/user/trojita-google-contacts.timer
