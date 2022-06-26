{%- set blacklist = salt["cmd.shell"]("qemu-ga --blacklist ? | grep -vE '^(guest-fsfreeze|guest-sync)' | sort -V")|replace("\n", ",") %}

qemu-guest-agent_override:
  file.managed:
    - name: /etc/systemd/system/qemu-guest-agent.service.d/override.conf
    - user: root
    - group: root
    - mode: 0644
    - makedirs: True
    - contents: |
        [Service]
        ExecStart=
        ExecStart=-/usr/sbin/qemu-ga --blacklist={{ blacklist }}

qemu-guest-agent_daemon_reload:
  cmd.watch:
    - name: systemctl daemon-reload
    - watch:
      - file: qemu-guest-agent_override

qemu-guest-agent_restart_and_enable:
  service.running:
    - name: qemu-guest-agent
    - enable: True
    - watch:
      - file: qemu-guest-agent_override
    - require:
      - cmd: qemu-guest-agent_daemon_reload
