# this module to snapshot 'home' lvm volume periodically
lvm_snapshot_backup_script:
  file.managed:
    - name: /usr/local/sbin/lvm_snapshot.sh
    - mode: 0700
    - user: root
    - group: root
    - source: salt://{{ tpldir }}/files/lvm_snapshot.sh

# not a proper way to manage cron jobs
# not ideal for deleting orphaned jobs...
lvm_snapshot_cron_job:
  cron.present:
    - name: /usr/local/sbin/lvm_snapshot.sh
    - minute: 0
    - hour: 2
    - identifier: lvm_snapshot.sh
