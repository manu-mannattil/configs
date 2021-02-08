// Resources for user.js hardening:
//
//   * https://www.privacytools.io/browsers/#about_config
//   * https://github.com/ghacksuserjs/ghacks-user.js/
//
// A much better way to be safe from your browser is to browse the web
// less.  It also has the (positive) side effect of making you more
// productive, healthier, and happier.
//

// ------------- Privacy -------------

// Isolate all browser identifier sources (e.g. cookies) to the first
// party domain, with the goal of preventing tracking across different
// domains.
user_pref("privacy.firstparty.isolate", true);

// Make Firefox more resistant to browser fingerprinting.  This breaks
// quite a few websites by setting unique nonstandard window resolutions
// such as 1916x933, which is also the dumbest way to make your browser
// less unique.
// user_pref("privacy.resistFingerprinting", true);

// Limit fingerprinting.
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);

// Block cryptomining.
user_pref("privacy.trackingprotection.cryptomining.enabled", true);

// Block social media tracking.
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

// Disables sending additional analytics to web servers.
// https://developer.mozilla.org/en-US/docs/Web/API/Navigator/sendBeacon
user_pref("beacon.enabled", false);

// Don't allow websites to control system clipboard.  Useful to paste
// long passwords (you might have to use CUA shortcuts though).
user_pref("dom.event.clipboardevents.enabled", false);

// Perform DNS lookups through the SOCKS proxy itself.
user_pref("network.proxy.socks_remote_dns", true);

// Disable "features" like Pocket and Hello.
user_pref("browser.pocket.enabled", false);
user_pref("loop.enabled", false);

// Disable "safe" browsing/phishing "protection".
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);

// Do not restore previous tabs.
user_pref("browser.sessionstore.max_tabs_undo", 0);

// Block third-party cookies.
user_pref("network.cookie.cookieBehavior", 1);

// Disable Firefox prefetching pages it thinks you will visit next.
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false);
user_pref("network.prefetch-next", false);

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

// All DNS queries over HTTPS (DoH).  If a query fails, fall back to
// conventional resolution.
user_pref("network.trr.mode", 2);

// DNS server used for resolving the address in network.trr.uri.
user_pref("network.trr.bootstrapAddress", "1.1.1.1");

// DNS over HTTPS (DoH) with CloudFlare's DNS.
// Alternative DoH servers: https://github.com/curl/curl/wiki/DNS-over-HTTPS
user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");

// Enable encrypted server name indication (SNI), which conceals the
// hostname during TLS connections: https://www.cloudflare.com/ssl/encrypted-sni/
user_pref("network.security.esni.enabled", true);

// Stop annoying me with notifications (and asking about them).
user_pref("dom.webnotifications.enabled", false);

// Don't record information about the current browser session and don't
// attempt to restore it automatically.
user_pref("browser.sessionstore.enabled", false);
user_pref("browser.sessionstore.max_tabs_undo", 0);
user_pref("browser.sessionstore.max_windows_undo", 0);
user_pref("browser.sessionstore.restore_on_demand", false);

// Allow extensions in private windows by default.
// (I only install extensions I trust.)
user_pref("extensions.allowPrivateBrowsingByDefault", true);

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
