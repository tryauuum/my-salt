unix_wipe_root_password:
  cmd.run:
    - name: usermod --password '!' root
    - stateful: True
