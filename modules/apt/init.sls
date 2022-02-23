unattended-upgrades:
  pkg.installed:
    - require_in:
      - file: apt_unattended

apt_unattended:
  file.managed:
    - name: /etc/apt/apt.conf.d/50unattended-upgrades
    - mode: 0644
    - user: root
    - group: root
    - contents: |
        Dpkg::Options {
            "--force-confdef";
            "--force-confold";
        }
        Unattended-Upgrade::Origins-Pattern {
            "origin=*";
        }
        Unattended-Upgrade::Package-Blacklist {
        };
        Unattended-Upgrade::DevRelease "auto";

apt_salt_config:
  file.managed:
    - name: /etc/apt/sources.list.d/saltstack.list
    - mode: 0644
    - user: root
    - group: root
    - contents: |
        deb [arch=amd64] http://repo.saltstack.com/py3/ubuntu/20.04/amd64/latest focal main
