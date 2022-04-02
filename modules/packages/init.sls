packages_install:
  pkg.installed:
    - pkgs:
      - binutils
      - curl
      - ethtool
      - git
      - htop
      - kpartx
{%- if grains.id == 'melchior' %}
      - msr-tools
{%- endif %}
      - nmap
      - openssh-server
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
