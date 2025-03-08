sysctl_config:
  file.managed:
    - name: /etc/sysctl.conf
    - mode: 0644
    - contents: |
        kernel.dmesg_restrict = 1
        # wonder if it is a good choice
        kernel.panic = 300
        kernel.sysrq = 1
        net.ipv4.conf.all.arp_announce = 2
        net.ipv4.conf.all.arp_ignore = 1
        net.ipv4.conf.all.ignore_routes_with_linkdown = 1
        net.ipv4.conf.all.log_martians = 1
        net.ipv4.conf.default.arp_announce = 2
        net.ipv4.conf.default.arp_ignore = 1
        net.ipv4.conf.default.ignore_routes_with_linkdown = 1
        net.ipv4.conf.default.log_martians = 1
        net.ipv4.neigh.default.gc_thresh1 = 5000
        net.ipv4.neigh.default.gc_thresh2 = 10000
        net.ipv4.neigh.default.gc_thresh3 = 20000
        # want swap for suspend only
        vm.swappiness = 0

sysctl_apply:
  cmd.run:
    # need to always run this, not only on file change
    - name: sysctl -q -p /etc/sysctl.conf
    - stateful: True
