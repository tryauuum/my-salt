base:
  '*':
    - modules.salt-minion
    - modules.grub
    - modules.packages
    - modules.rcfiles
    - modules.vim
    - modules.apt
    - modules.sysctl
    - modules.fstab
    - modules.unix
{%- if salt.pkg.version('docker-ce') %}
    - modules.docker
{%- endif %}
{%- if salt['file.is_link']('/dev/mapper/vg-home') %}
    - modules.lvm_snapshot
{%- endif %}
