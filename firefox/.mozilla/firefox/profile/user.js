// Resources for user.js hardening:
//
// * https://ffprofile.com/
// * https://github.com/pyllyukko/user.js

// Don't allow websites to control system clipboard.  Useful to paste
// long passwords (you might have to use CUA shortcuts though).
user_pref("dom.event.clipboardevents.enabled", false);

// Perform DNS lookups through the SOCKS proxy itself.
user_pref("network.proxy.socks_remote_dns", true);

// Disable "features" like Pocket and Hello.
user_pref("browser.pocket.enabled", false);
user_pref("loop.enabled", false);

// Enable spell checking for all (i.e., for both multi-line and
// single-line) text boxes.
user_pref("layout.spellcheckDefault", 2);

// Don't use the mailcap file to look up file/program associations.
user_pref("helpers.global_mailcap_file", "");
user_pref("helpers.private_mailcap_file", "");

// Disable "safe" browsing/phishing "protection".
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);

// Do not restore previous tabs.
user_pref("browser.sessionstore.max_tabs_undo", 0);

// Block third-party cookies.
user_pref("network.cookie.cookieBehavior", 1);

// Font preferences.
user_pref("font.default.x-western", "sans-serif");
user_pref("font.name.sans-serif.x-western", "Nimbus Sans L");
user_pref("font.name.serif.x-western", "Nimbus Roman No9 L");

// Always ask for where to store downloaded files.
user_pref("browser.download.useDownloadDir", false);

// Disable autofilling of saved addresses.
user_pref("extensions.formautofill.addresses.enabled", false);

// Minimize crash reporting and other communications with Mozilla.
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
user_pref("dom.ipc.plugins.reportCrashURL", false);
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.selfsupport.url", "");
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// Disable "Recommended by Pocket" in Firefox Quantum.
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);

// Resolve DNS over HTTPS (DoH).
user_pref("network.trr.mode", 2);
user_pref("trr.bootstrapAddress", "1.1.1.1");

// Don't cycle tabs (old behavior).
user_pref("browser.ctrlTab.recentlyUsedOrder", false);

// Don't warn on closing multiple tabs.
user_pref("browser.tabs.warnOnClose", false);

// Blank startup and newtab page.
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.newtabpage.enabled", false);

// Stop annoying me with notifications (and asking about them).
user_pref("dom.webnotifications.enabled", false);

// Reader-view preferences.
user_pref("reader.color_scheme", "dark");
user_pref("reader.content_width", 4);
user_pref("reader.font_size", 2);
user_pref("reader.line_height", 3);
