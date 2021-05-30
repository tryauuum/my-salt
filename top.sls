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
{%- if salt.pkg.version('docker-ce') %}
    - modules.docker
{%- endif %}
