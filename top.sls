base:
  '*':
    - modules.salt-minion
    - modules.grub
    - modules.packages
    - modules.rcfiles
    - modules.vim
    - modules.apt
    - modules.sysctl
    - modules.module_blacklist
    - modules.fstab
    - modules.unix
    - modules.locale
{%- if salt.pkg.version('docker-ce') %}
    - modules.docker
{%- endif %}
{%- if salt['file.is_link']('/dev/mapper/vg-home') %}
    - modules.lvm_snapshot
{%- endif %}
{%- if salt.pkg.version('firefox') %}
    - modules.firefox
{%- endif %}
