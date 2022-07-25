syndaemon_dirs_1:
  file.directory:
    - names:
      - /home/{{ grains["unprivileged_user"] }}/.config/systemd
      - /home/{{ grains["unprivileged_user"] }}/.config/systemd/user
    - user: {{ grains["unprivileged_user"] }}
    - group: {{ grains["unprivileged_user"] }}
    - mode: 0700

syndaemon_dirs_2:
  file.directory:
    - name: /home/{{ grains["unprivileged_user"] }}/.config/systemd/user/default.target.wants
    - user: {{ grains["unprivileged_user"] }}
    - group: {{ grains["unprivileged_user"] }}
    - mode: 0755

syndaemon_service:
  file.managed:
    - name: /home/{{ grains["unprivileged_user"] }}/.config/systemd/user/syndaemon.service
    - user: {{ grains["unprivileged_user"] }}
    - group: {{ grains["unprivileged_user"] }}
    - mode: 0644
    - contents: |
        [Unit]
        Description=Syndaemon with a "-t" switch which Xubuntu does not feature
        StartLimitIntervalSec=0

        [Service]
        Type=simple
        ExecStart=/usr/bin/syndaemon -i 1 -m 150 -t -v
        Restart=always
        RestartSec=3

        [Install]
        WantedBy=default.target

syndaemon_service_enable:
  file.symlink:
    - name: /home/{{ grains["unprivileged_user"] }}/.config/systemd/user/default.target.wants/syndaemon.service
    - target: /home/{{ grains["unprivileged_user"] }}/.config/systemd/user/syndaemon.service
    - user: {{ grains["unprivileged_user"] }}
    - group: {{ grains["unprivileged_user"] }}

# that's all
# we cannot really reload user's systemd daemon as root
# FIXME maybe add check running?
