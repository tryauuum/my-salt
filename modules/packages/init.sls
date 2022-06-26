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
{%- if grains.get("virtual") == "kvm" %}
      - qemu-guest-agent
{%- else %}
      - smartmontools
{%- endif %}
      - vim
      - whois
{%- if salt.pkg.version('xubuntu-core') %}  # only if we have GUI
  {%- if not salt.pkg.version('fluxgui') %}
      - redshift-gtk
  {%- endif %}
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
{%- if grains.get("virtual") == "kvm" %}
      - smartmontools
{%- endif %}
      - snapd
      - transmission-gtk
      - ubuntu-server           # byobu and others
      - ufw
      - zabbix-agent-timeweb
