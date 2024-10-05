unattended-upgrades:
  pkg.installed:
    - require_in:
      - file: apt_unattended

apt_fuck_snapd:
  file.managed:
    - name: /etc/apt/preferences.d/snapd
    - mode: 0644
    - user: root
    - group: root
    - contents: |
        Package: snapd
        Pin: release *
        Pin-Priority: -1

apt_fuck_snapd_continued:
  file.managed:
    - name: /etc/apt/preferences.d/mozilla-firefox
    - mode: 0644
    - user: root
    - group: root
    - contents: |
        Package: firefox*
        Pin: release o=LP-PPA-mozillateam
        Pin-Priority: 1001

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

apt_key:
  file.decode:
    - name: /etc/apt/trusted.gpg.d/mozillateam-ubuntu-ppa.gpg
    - encoding_type: base64
    - encoded_data: |
        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


apt_firefox_config:
  file.managed:
    - name: /etc/apt/sources.list.d/mozillateam-ubuntu-ppa.list
    - mode: 0644
    - user: root
    - group: root
    - contents: |
        deb https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu/ {{ grains["lsb_distrib_codename"] }} main
        # deb-src https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu/ {{ grains["lsb_distrib_codename"] }} main

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
