locale_locales_present:
  locale.present:
    - names:
      - en_US.UTF-8
      - fi_FI.UTF-8
      - ru_RU.UTF-8
    - require_in:
      - file: locale_update_file_in_etc
      - locale: locale_set_default

locale_update_file_in_etc:
  file.managed:
    - name: /etc/default/locale
    - user: root
    - group: root
    - perms: 0644
    - contents: |
        LANG=en_US.UTF-8
        LC_TIME=ru_RU.UTF-8
        LC_PAPER=ru_RU.UTF-8

# I think this is not required
# but just in case, if systemd/dbus caches it somewhere...
locale_set_default:
  locale.system:
    - name: en_US.UTF-8
