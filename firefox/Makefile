.PHONY: install uninstall clean

install:
	wget --continue --no-config --progress=bar -O firefox.tar.bz2 \
		"https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
	tar xjf firefox.tar.bz2

	rm -rf /opt/firefox
	cp -r firefox /opt/
	ln -fs /opt/firefox/firefox /usr/bin

	mkdir -p /usr/share/applications
	cp -f firefox.desktop /usr/share/applications/firefox.desktop

	for size in 16 32 48 64 128; do \
		mkdir -p "/usr/share/icons/hicolor/$${size}x$${size}/apps"; \
		cp -f "firefox/browser/chrome/icons/default/default$$size.png" \
		"/usr/share/icons/hicolor/$${size}x$${size}/apps/firefox.png"; \
	done;

	mkdir -p /usr/share/man/man1/
	cp -f firefox.1 /usr/share/man/man1/
	chmod 644 /usr/share/man/man1/firefox.1

	mkdir -p /etc/firefox/policies
	cp -f policies.json /etc/firefox/policies

	# If we've reached this point without errors, assume that the
	# installation has succeeded and remove temporary files.
	make clean

uninstall:
	rm -rf /opt/firefox
	rm -f /usr/bin/firefox
	rm -f /usr/share/applications/firefox.desktop
	rm -f /usr/share/man/man1/firefox.1
	for size in 16 32 48 64 128; do \
		rm -f "/usr/share/icons/hicolor/$${size}x$${size}/apps/firefox.png"; \
	done;

clean:
	rm -f firefox.tar.bz2
	rm -rf firefox
