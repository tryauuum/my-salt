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
