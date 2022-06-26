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

{%- set zabbix_repo_files = salt["cmd.run"]("grep -rFlsa zabbix.repo.timeweb.ru /etc/apt/", ignore_retcode=True) %}
{%- if zabbix_repo_files %}
apt_timeweb_repo_absent:
  file.absent:
    - names:
  {%- for file in zabbix_repo_files.split("\n") %}
      - {{ file }}
  {%- endfor %}
{%- endif %}
