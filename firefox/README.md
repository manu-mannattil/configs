# Firefox on Linux

The Firefox version shipped with [Debian stable][deb] is usually
outdated.  This makefile fetches the latest x64 tarball distributed by
Mozilla and unpacks it in the right directories.  It also installs
a [policy file][policy] that disables some telemetry and as well as
annoying ["update available"][update] notifications.  Run `make install`
to install (or update) the latest version and `make clean` afterwards to
remove temporary files.

[deb]: https://packages.debian.org/search?suite=stable&searchon=names&keywords=firefox
[policy]: https://github.com/mozilla/policy-templates
[update]: https://linuxreviews.org/HOWTO_Make_Mozilla_Firefox_Stop_Nagging_You_About_Updates_And_Other_Annoying_Idiocy
