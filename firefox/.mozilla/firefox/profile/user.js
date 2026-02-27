// Resources for Firefox tweaking:
//
//    https://github.com/arkenfox/user.js
//    https://github.com/yokoffing/Betterfox
//    https://github.com/corbindavenport/just-the-browser/tree/main/firefox
//
// Librewolf policies file: https://codeberg.org/librewolf/settings/src/branch/master/distribution/policies.json
// Librewolf config: https://codeberg.org/librewolf/settings/src/branch/master/librewolf.cfg
//
// A much better way to be safe from your browser is to
// browse the web less.  It also has the (positive) side
// effect of making you fitter, happier, more productive,
// comfortable, not drinking too much ...
//
// Notes
// -----
//
// 1. If you've set a particular preference and it's not
//    being honored by Firefox, check (i) if there are typos,
//    (ii) if the preference value is properly quoted (or not),
//    (iii) if there _is_ a semicolon at the end of the line.
//
// 2. Some of these preferences are redunant as they're being
//    set globally using the policies.json file.
//

// ------------- Updates -------------

// Disable auto updates and notifications.  Doesn't work since FF 88;
// create policies file instead:
// https://linuxreviews.org/HOWTO_Make_Mozilla_Firefox_Stop_Nagging_You_About_Updates_And_Other_Annoying_Idiocy
user_pref("app.update.BITS.enabled", false);
user_pref("app.update.auto", false);
user_pref("app.update.autoInstallEnabled", false);
user_pref("app.update.background.scheduling.enabled", false);
user_pref("app.update.checkInstallTime", false);
user_pref("app.update.doorhanger", false);
user_pref("app.update.enabled", false);
user_pref("app.update.lastUpdateTime.background-update-timer", 0);
user_pref("app.update.service.enabled", false);
user_pref("app.update.silent", true);
user_pref("app.update.url", "");
user_pref("app.update.url.manual", "");
user_pref("lightweightThemes.update.enabled", false);

// ------------- Privacy and Security -------------

// Block social media tracking.
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

// Disables sending additional analytics to web servers.
// https://developer.mozilla.org/en-US/docs/Web/API/Navigator/sendBeacon
// This breaks some sites, e.g., perplexity.ai.
// user_pref("beacon.enabled", false);

// Perform DNS lookups through the SOCKS proxy itself.
user_pref("network.proxy.socks_remote_dns", true);

// Disable autofilling BS.
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.formautofill.heuristics.enabled", false);

// Don't record information about the current browser session and don't
// attempt to restore it automatically.
user_pref("browser.sessionstore.enabled", false);
user_pref("browser.sessionstore.max_resumed_crashes", 0);
user_pref("browser.sessionstore.max_tabs_undo", 0);
user_pref("browser.sessionstore.max_windows_undo", 0);
user_pref("browser.sessionstore.restore_on_demand", false);
user_pref("browser.sessionstore.resume_from_crash", false);

// Disable all sponsored crap and show nothing in activity stream.
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.enabled", false);
user_pref("browser.newtabpage.activity-stream.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.discoverystreamfeed", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.system.topsites", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts", false);
user_pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines", "");
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.rows", 0);
user_pref("browser.newtabpage.activity-stream.showSearch", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.enhanced", false);
user_pref("browser.newtabpage.pinned", "");
user_pref("browser.tabs.firefox-view", false);
user_pref("browser.urlbar.fakespot.featureGate", false);
user_pref("browser.urlbar.mdn.featureGate", false);
user_pref("browser.urlbar.pocket.featureGate", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.suggest.trending", false);
user_pref("browser.urlbar.trending.featureGate", false);
user_pref("browser.urlbar.weather.featureGate", false);
user_pref("browser.urlbar.yelp.featureGate", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsored", false);
user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSites", false);

// Quieter fox.
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);

// Allow "risky" downloads.
user_pref("dom.block_download_insecure", false);

// Minimize communications with Mozilla.
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("breakpad.reportURL", "");
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("captivedetect.canonicalURL", "");
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("default-browser-agent.enabled", false);
user_pref("network.captive-portal-service.enabled", false);
user_pref("network.connectivity-service.enabled", false);
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

// Disable "upload" feature on screenshots.
user_pref("extensions.screenshots.upload-disabled", true);

// Disable Firefox accounts.
user_pref("identity.fxaccounts.enabled", false);

// Disable "privacy-preserving ad measurement".
user_pref("dom.private-attribution.submission.enabled", false);

// ------------- AI nonsense -------------

user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ai.control.linkPreviewKeyPoints", "blocked");
user_pref("browser.ai.control.pdfjsAltText", "blocked");
user_pref("browser.ai.control.sidebarChatbot", "blocked");
user_pref("browser.ai.control.smartTabGroups", "blocked");
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.menu", false);
user_pref("browser.ml.enabled", false);
user_pref("browser.ml.enable", false);
user_pref("browser.ml.linkPreview.enabled", false);
user_pref("browser.ml.linkPreview.supportedLocales", "null");
user_pref("browser.ml.pageAssist.enabled", false);
user_pref("browser.ml.smartAssist.enabled", false);
user_pref("browser.preferences.aiControls", false);
user_pref("browser.search.visualSearch.featureGate", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("browser.tabs.groups.smart.userEnabled", false);
user_pref("browser.tabs.groups.smart.userEnable", false);
user_pref("browser.urlbar.quicksuggest.mlEnabled", false);
user_pref("extensions.ml.enabled", false);
user_pref("extensions.ui.mlmodel.hidden", true);
user_pref("pdfjs.enableAltText", false);
user_pref("places.semanticHistory.featureGate", false);
user_pref("sidebar.revamp", false);

// ------------- DNS -------------

// Cloudflare test page for DOH: https://1.1.1.1/help

// All DNS queries over HTTPS (DoH).  If a query fails, fall back to
// conventional resolution.
user_pref("network.trr.mode", 2);

// DNS server used for resolving the address in network.trr.uri.
user_pref("network.trr.bootstrapAddress", "9.9.9.9");

// DNS over HTTPS (DoH) with Quad9's DNS.
// Alternative DoH servers: https://github.com/curl/curl/wiki/DNS-over-HTTPS
user_pref("network.trr.uri", "https://family.cloudflare-dns.com/dns-query")

// Enable encrypted server name indication (SNI), which conceals the
// hostname during TLS connections: https://www.cloudflare.com/ssl/encrypted-sni/
user_pref("network.security.esni.enabled", true);

// ------------- Usability -------------

// Treat me like an adult.
user_pref("browser.aboutConfig.showWarning", false);

// Disable the Ctrl+Q quit shortcut.
user_pref("browser.quitShortcut.disabled", true);

// Disable menu popup on pressing the alt key.
user_pref("ui.key.menuAccessKeyFocuses", false);

// There is so much BS regarding how the new Firefox downloads files.
// I don't know if these options conflict each other (they probably do),
// but I'm getting the old behavior back.  This whole thing can be fixed
// by a few lines of if-else checks, but yet, here we are.
user_pref("browser.download.improvements_to_download_panel", false);
user_pref("browser.download.start_downloads_in_tmp_dir", true);
user_pref("browser.download.always_ask_before_handling_new_types", true);
user_pref("browser.download.useDownloadDir", false);
user_pref("browser.download.dir", "/tmp/downloads");
user_pref("browser.download.lastDir", "/tmp/downloads");

// Use the default download directory as the fallback
// directory for uploading as well.
user_pref("dom.input.fallbackUploadDir", "/tmp/downloads");

// Blank startup and newtab page.
user_pref("browser.newtab.preload", false);
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.onboarding.enabled", false);
user_pref("browser.startup.homepage", "about:blank");
user_pref("browser.startup.page", 0);

// Enable spell checking for all (i.e., for both multi-line and
// single-line) text boxes.
user_pref("layout.spellcheckDefault", 2);

// Enable loading of userChrome.css if available.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Highlight matching search terms.
user_pref("findbar.highlightAll", true);

// Disable narration in Reader.
user_pref("narrate.enabled", false);

// Don't cycle tabs (old behavior).
user_pref("browser.ctrlTab.recentlyUsedOrder", false);

// Don't warn on closing multiple tabs.
user_pref("browser.tabs.warnOnClose", false);

// New tabs open next to your current tab, not at the end.
user_pref("browser.tabs.insertAfterCurrent", true);

// Disable UI animations.
user_pref("toolkit.cosmeticAnimations.enabled", false);

// Font preferences.
user_pref("font.default.x-western", "sans-serif");
user_pref("font.name.sans-serif.x-western", "Nimbus Sans L");
user_pref("font.name.serif.x-western", "Nimbus Roman No9 L");

// Don't use the local ~/.mailcap file to look up file/program
// associations.  However, don't change helpers.global_mailcap_file,
// which should be /etc/mailcap (zoom.us links break otherwise, for
// instance).
user_pref("helpers.private_mailcap_file", "");

// Printer settings (no headers/footers).
user_pref("print.print_footercenter", "");
user_pref("print.print_footerleft", "");
user_pref("print.print_footerright", "");
user_pref("print.print_headercenter", "");
user_pref("print.print_headerleft", "");
user_pref("print.print_headerright", "");
user_pref("print.default_dpi", 300);

// Disable picture-in-picture and the Ctrl+Shift+] shortcut that toggles it.
user_pref("media.videocontrols.picture-in-picture.enabled", false);
user_pref("media.videocontrols.picture-in-picture.video-toggle.enabled", false);

// Don't trim HTTP/HTTPS off of URLs in the address bar.
user_pref("browser.urlbar.trimURLs", false);

// Display "Not Secure" icon and text on HTTP websites.
user_pref("security.insecure_connection_icon.enabled", true);
user_pref("security.insecure_connection_text.enabled", true);

// Make scrollbars wider than the default, and don't allow sites to make
// scrollbars narrow.
user_pref("widget.gtk.overlay-scrollbars.enabled", false);
user_pref("widget.non-native-theme.scrollbar.size.override", 15);
user_pref("layout.css.scrollbar-width-thin.disabled", true);

// Make title bar visible.
user_pref("browser.tabs.inTitlebar", 0);

// Whether copying the entire URL from the location bar will put a human
// readable (percent-decoded) URL on the clipboard.
user_pref("browser.urlbar.decodeURLsOnCopy", true);

// Always show bookmarks in the toolbar.
user_pref("browser.toolbars.bookmarks.visibility", "always");

// Set of zoom values that Firefox can use.  The only addition to this
// from the default list is 88% zoom, which I added so that 168 DPI text
// appears as 96 DPI text on my HiDPI laptop screen with a Zoom factor
// of 2.  The math is as follows: (168/96)/2 = 0.875 = 87.5% ~ 88%.
user_pref("toolkit.zoomManager.zoomValues", ".3,.5,.67,.8,.875,.9,1,1.1,1.2,1.33,1.5,1.7,2,2.4,3,4,5");

// Better smooth scrolling.
// https://github.com/yokoffing/Betterfox
user_pref("general.smoothScroll", true);
user_pref("mousewheel.default.delta_multiplier_y", 300);
user_pref("general.smoothScroll.msdPhysics.enabled", true);

// Wrap long lines while viewing source and in devtools.
user_pref("view_source.wrap_long_lines", true);
user_pref("devtools.debugger.ui.editor-wrapping", true);

// Disable media autoplay.  I would ideally want to better understand
// these options, but Mozilla keeps changing them all the time, so
// such a task would not be worth it.
// https://news.ycombinator.com/item?id=28131896
user_pref("media.autoplay.blocking_policy", 2);
user_pref("media.autoplay.allow-muted", false);
user_pref("media.autoplay.block-event.enabled", true);
user_pref("media.autoplay.block-webaudio", true);
user_pref("media.autoplay.default", 5);
user_pref("media.autoplay.enabled.user-gestures-needed", false);

// Don't show a preview of the tab when I put my mouse cursor on it.
user_pref("browser.tabs.hoverPreview.enabled", false);

// Enable VAAPI video acceleration.
// To check if video acceleration is working install the intel-gpu-tools
// Debian package and run intel_gpu_top as sudo.  The video engine
// should show load when these options are active.
user_pref("gfx.webrender.all", true);
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.ffmpeg.vaapi-drm-display.enabled", true);
user_pref("media.ffvpx.enabled", false);

// Remove new sidebar.
user_pref("sidebar.revamp", false);

// Disable in-browser translations -- they're slow and of poor quality.
user_pref("browser.translations.automaticallyPopup", false);
user_pref("browser.translations.enable", false);
user_pref("browser.translations.panelShown", false);

// Disable grouping tabs.
user_pref("browser.tabs.groups.enabled", false);

// Disable the right-click menus that allow you to copy the URL + add
// parameters that highlight the current text selection.  Just clutters
// the menu in my opinion.
user_pref("dom.text_fragments.enabled", false);
user_pref("dom.text_fragments.create_text_fragment.enabled", false);

// Internal custom pref to ensure that we've reach the end without syntax errors.
user_pref("_user.js.parrot", "SUCCESS: Firefox is not dead, he's, he's restin'!");
