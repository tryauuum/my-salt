# https://make-linux-fast-again.com/ WTF


grub_fix_defaults:
  file.replace:
    - name: /etc/default/grub
    - pattern: '^GRUB_CMDLINE_LINUX_DEFAULT=.*$'
# another dowside (aside from obvious security hole) is that we lose default values
# like "quiet splash". But who cares about them anyway?
    - repl: 'GRUB_CMDLINE_LINUX_DEFAULT="noibrs noibpb nopti nospectre_v2 nospectre_v1 l1tf=off nospec_store_bypass_disable no_stf_barrier mds=off tsx=on tsx_async_abort=off mitigations=off"'

grub_regen_config:
  cmd.wait:
    - name: 'update-grub2'
    - watch:
      - file: grub_fix_defaults
