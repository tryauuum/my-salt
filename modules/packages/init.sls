packages_install:
  pkg.installed:
    - pkgs:
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
      - wireshark # FIXME add a condition

packages_purge:
  pkg.purged:
    - pkgs:
      - landscape-common
      - light-locker
      - mlocate
      - network-manager-openvpn # don't need it now
      - openvpn                 # don't need it now
      - os-prober
      - pidgin
      - snapd
      - transmission-gtk
