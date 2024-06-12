# The Firefox version shipped with Debian stable [1] is
# usually outdated.  This makefile fetches the latest x64
# tarball distributed by Mozilla and unpacks it in the right
# directories.  It also installs a policy file [2] that
# disables some telemetry and as well as annoying "update
# available" [3] notifications.
#
# Run `make install` to install (or update) the latest
# version and `make clean` afterwards to remove temporary
# files.
#
# [1]: https://packages.debian.org/search?suite=stable&searchon=names&keywords=firefox
# [2]: https://github.com/mozilla/policy-templates
# [3]: https://linuxreviews.org/HOWTO_Make_Mozilla_Firefox_Stop_Nagging_You_About_Updates_And_Other_Annoying_Idiocy
#

.PHONY: install uninstall clean

install:
	wget --continue --no-config --progress=bar -O firefox.tar.bz2 \
		"https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US"
	tar xjf firefox.tar.bz2

	rm -rf /opt/firefox
	cp -r firefox /opt/
	chmod -R g=rwX,o=rX /opt/firefox
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
