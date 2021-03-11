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
      - openvpn
      - pv
      - light-locker
      - nmap
      - openssh-server
      - pwgen
      - screen
      - vim
      - whois
      - wireshark # FIXME add a condition

packages_purge:
  pkg.purged:
    - pkgs:
      - mlocate
      - os-prober
      - pidgin
      - snapd
      - transmission-gtk
