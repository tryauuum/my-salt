packages_install:
  pkg.installed:
    - pkgs:
      - curl
      - git
      - htop
{%- if grains.id == 'melchior' %}
      - msr-tools
{%- endif %}
#     - network-manager-openvpn
      - openvpn
#     - redshift
      - screen
      - vim
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
