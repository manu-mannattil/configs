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
