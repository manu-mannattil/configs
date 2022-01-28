// Resource for user.js hardening: https://github.com/arkenfox/user.js
//
// A much better way to be safe from your browser is to browse the web
// less.  It also has the (positive) side effect of making you more
// productive, healthier, and happier.
//

// ------------- Updates -------------

// Disable auto updates and notifications.  Doesn't work since FF 88;
// create policies file instead:
// https://linuxreviews.org/HOWTO_Make_Mozilla_Firefox_Stop_Nagging_You_About_Updates_And_Other_Annoying_Idiocy
user_pref("app.update.auto", false);
user_pref("app.update.autoInstallEnabled", false);
user_pref("app.update.background.scheduling.enabled", false);
user_pref("app.update.checkInstallTime", false);
user_pref("app.update.doorhanger", false);
user_pref("app.update.enabled", false);
user_pref("app.update.lastUpdateTime.background-update-timer", 0);
user_pref("app.update.silent", true);

// ------------- Privacy -------------

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

// Allow "risky" downloads.
user_pref("dom.block_download_insecure", false);

// Minimize communications with Mozilla.
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("breakpad.reportURL", "");
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);

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
