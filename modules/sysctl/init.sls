sysctl_config:
  file.managed:
    - name: /etc/sysctl.conf
    - mode: 0644
    - contents: |
        kernel.dmesg_restrict = 1
        # wonder if it is a good choice
        kernel.panic = 300
        kernel.sysrq = 1
        net.ipv4.conf.all.log_martians = 1
        # want swap for suspend only
        vm.swappiness = 0

sysctl_apply:
  cmd.run:
    - name: sysctl -q -p /etc/sysctl.conf
    - onchanges:
      - sysctl_config
