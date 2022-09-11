# what kind of things people do when they desire not to use pillar
{%- set options = ["ipv6.disable=1"] %}
{%- if grains.id in ["fuzz", "melchior", "family-laptop"] %}
    {%- do options.append("mitigations=off") %}
{%- endif %}

grub_fix_defaults:
  file.replace:
    - name: /etc/default/grub
    - pattern: '^GRUB_CMDLINE_LINUX_DEFAULT=.*$'
    - repl: 'GRUB_CMDLINE_LINUX_DEFAULT="{{ options | join(' ') }}"'
# backups are for pussies, real men delete their stuff with a trusty 'rm -rf /'
# in daily cron
    - backup: False

grub_regen_config:
  cmd.wait:
    - name: 'update-grub'
    - watch:
      - file: grub_fix_defaults
