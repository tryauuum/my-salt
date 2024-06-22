fstab_proc_secure:
  mount.mounted:
    - name: /proc
    - device: proc
    - fstype: proc
    - opts:
      - rw
      - nosuid
      - nodev
      - noexec
      - relatime
# secure as fuck. https://www.kernel.org/doc/Documentation/filesystems/proc.txt
      - hidepid=invisible
