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
      - pwgen
      - screen
      - openssh-server
      - vim
      - whois
      - wireshark

packages_purge:
  pkg.purged:
    - pkgs:
      - mlocate
      - os-prober
      - pidgin
      - snapd
      - thunderbird
      - transmission-gtk
