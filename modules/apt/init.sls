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
        Unattended-Upgrade::Allowed-Origins {
            "${distro_id}:${distro_codename}";
            "${distro_id}:${distro_codename}-security";
            "${distro_id}:${distro_codename}-updates";
            "${distro_id}ESMApps:${distro_codename}-apps-security";
            "${distro_id}ESM:${distro_codename}-infra-security";
        };
        Unattended-Upgrade::Package-Blacklist {
        };
        Unattended-Upgrade::DevRelease "auto";
