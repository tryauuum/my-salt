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
#     - network-manager-openvpn
      - nmap
      - openssh-server
      - openvpn
      - pv
      - pwgen
      - screen
      - sipcalc
      - vim
      - whois
      - wireshark # FIXME add a condition

packages_purge:
  pkg.purged:
    - pkgs:
      - landscape-common
      - light-locker
      - mlocate
      - os-prober
      - pidgin
      - snapd
      - transmission-gtk
