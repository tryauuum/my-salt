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

packages_purge_snap_more:
  file.absent:
    - names:
      - /root/snap
{%- if grains['unprivileged_user'] %}
      - /home/{{ grains['unprivileged_user'] }}/snap
{%- endif %}
    - require:
      - pkg: packages_purge
