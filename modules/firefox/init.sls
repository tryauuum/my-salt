{%- if grains['unprivileged_user'] %}
  {%- for DIR in salt['cmd.shell']('ls -d ~' + grains["unprivileged_user"] +
      '/.mozilla/firefox/*default*/', ignore_retcode=True).split('\n') %}
firefox_user_js_{{ DIR }}:
  file.managed:
    - name: {{ DIR }}/user.js
    - mode: 0600
    - user: {{ grains['unprivileged_user'] }}
    - group: {{ grains['unprivileged_user'] }}
    - contents: |
        user_pref("browser.aboutConfig.showWarning", false);
        // force DoH only
        user_pref("network.trr.mode", 2);
        user_pref("network.trr.uri", "https://mozilla.cloudflare-dns.com/dns-query");
        user_pref("network.trr.bootstrapAddress", "1.1.1.1");
        // no reason not to trust cloudflare's rfc1918 hosts
        user_pref("network.trr.allow-rfc1918", true);
        // fuck http
        user_pref("dom.security.https_only_mode", true);
        user_pref("dom.security.https_only_mode.upgrade_local", true);
        user_pref("dom.security.https_only_mode.upgrade_onion", true);
        // just a silent voice against unification of URL bar and search bar...
        // FIXME doesn't look like it works
        user_pref("browser.search.widget.inNavBar", true);
        // more screen space for me
        user_pref("browser.tabs.inTitlebar", 1);
        // computers were a mistake
        user_pref("ui.key.menuAccessKeyFocuses", false);
        user_pref("browser.sessionstore.interval", 3600000);
        user_pref("permissions.default.desktop-notification", 2);
  {%- endfor %}
{%- endif %}
