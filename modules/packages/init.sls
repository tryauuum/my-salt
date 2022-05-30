packages_debconf:
  debconf.set:
    - name: postfix
    - data:
        'postfix/mailname': {'type': 'string', 'value': {{ grains.id }} }
        'postfix/main_mailer_type': {'type': 'select', 'value': 'Local only'}

packages_install:
  pkg.installed:
    - pkgs:
      - binutils
      - curl
      - ethtool
      - git
      - htop
      - kpartx
      - mailutils
{%- if grains.id == 'melchior' %}
      - msr-tools
{%- endif %}
      - nmap
      - openssh-server
      - postfix
      - pv
      - pwgen
      - screen
      - sipcalc
      - smartmontools
      - vim
      - whois
{#- wireshark only installed if GUI already exists #}
{%- if salt.pkg.version('xubuntu-core') %}
      - wireshark
{%- endif %}
    - require:
        - debconf: postfix

packages_purge:
  pkg.purged:
    - pkgs:
      - cloud-init
      - landscape-common
      - light-locker
      - mlocate
      - network-manager-openvpn # don't need it now
      - openvpn                 # don't need it now
      - os-prober
      - pidgin
      - snapd
      - transmission-gtk
      - ubuntu-server           # byobu and others
