// Resource for user.js hardening: https://github.com/arkenfox/user.js
//
// A much better way to be safe from your browser is to browse the web
// less.  It also has the (positive) side effect of making you more
// productive, healthier, and happier.
//

// ------------- Privacy -------------

// Block cryptomining.
user_pref("privacy.trackingprotection.cryptomining.enabled", true);

// Block social media tracking.
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

// Disables sending additional analytics to web servers.
// https://developer.mozilla.org/en-US/docs/Web/API/Navigator/sendBeacon
user_pref("beacon.enabled", false);

// Perform DNS lookups through the SOCKS proxy itself.
user_pref("network.proxy.socks_remote_dns", true);

// Disable autofilling of saved addresses.
user_pref("extensions.formautofill.addresses.enabled", false);

// Don't record information about the current browser session and don't
// attempt to restore it automatically.
user_pref("browser.sessionstore.enabled", false);
user_pref("browser.sessionstore.max_tabs_undo", 0);
user_pref("browser.sessionstore.max_windows_undo", 0);
user_pref("browser.sessionstore.restore_on_demand", false);

// Allow extensions in private windows by default.
// (I only install extensions I trust.)
user_pref("extensions.allowPrivateBrowsingByDefault", true);

// ------------- DNS -------------

// All DNS queries over HTTPS (DoH).  If a query fails, fall back to
// conventional resolution.
user_pref("network.trr.mode", 2);

// DNS server used for resolving the address in network.trr.uri.
user_pref("network.trr.bootstrapAddress", "9.9.9.9");

// DNS over HTTPS (DoH) with Quad9's DNS.
// Alternative DoH servers: https://github.com/curl/curl/wiki/DNS-over-HTTPS
user_pref("network.trr.uri", "https://dns.quad9.net/dns-query");

// Enable encrypted server name indication (SNI), which conceals the
// hostname during TLS connections: https://www.cloudflare.com/ssl/encrypted-sni/
user_pref("network.security.esni.enabled", true);

// ------------- Usability -------------

// Blank startup and newtab page.
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.newtabpage.enabled", false);

// Enable spell checking for all (i.e., for both multi-line and
// single-line) text boxes.
user_pref("layout.spellcheckDefault", 2);

// Enable loading of userChrome.css if available.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// This is like the $GDK_SCALE environment variable that GTK+ uses for
// HiDPI scaling, but allows fractional scaling.
// user_pref("layout.css.devPixelsPerPx", 1.75);

// Highlight matching search terms.
user_pref("findbar.highlightAll", true);

// Reader-view preferences.
user_pref("reader.color_scheme", "dark");
user_pref("reader.content_width", 4);
user_pref("reader.font_size", 2);
user_pref("reader.line_height", 3);

// Don't cycle tabs (old behavior).
user_pref("browser.ctrlTab.recentlyUsedOrder", false);

// Don't warn on closing multiple tabs.
user_pref("browser.tabs.warnOnClose", false);

// Disable UI animations.
user_pref("toolkit.cosmeticAnimations.enabled", false);

// Font preferences.
user_pref("font.default.x-western", "sans-serif");
user_pref("font.name.sans-serif.x-western", "Nimbus Sans L");
user_pref("font.name.serif.x-western", "Nimbus Roman No9 L");

// Always ask for where to store downloaded files.
user_pref("browser.download.useDownloadDir", false);

// Don't use the mailcap file to look up file/program associations.
user_pref("helpers.global_mailcap_file", "");
user_pref("helpers.private_mailcap_file", "");
