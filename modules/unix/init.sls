unix_wipe_root_password:
  cmd.run:
    - name: usermod --password '!' root
    - stateful: True

# FIXME this doesn't belong here, but I don't have time for "generic sbin" module

unix_kvm_exec:
  file.managed:
    - name: /usr/local/sbin/kvm_exec.py
    - user: root
    - group: root
    - mode: 0700
    - source: salt://{{ tpldir }}/files/kvm_exec.py
