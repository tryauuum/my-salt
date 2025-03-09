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
        xsFNBGYov84BEADSrLhiWvqL3JJ3fTxjCGD4+viIUBS4eLSc7+Q7SyHm/wWfYNwTEqEvMMM9brWQ
        yC7xyE2JBlVk5/yYHkAQz3f8rbkv6ge3J8Z7G4ZwHziI45xJKJ0M9SgJH24WlGxmbbFfK4SGFNlg
        9x1Z0m5liU3dUSfhvTQdmBNqwRCAjJLZSiS03IA056V9r3ACejwpNiXzOnTsALZC2viszGiI854k
        qhUhFIJ/cnWKSbAcg6cy3ZAsne6KvxJVPsdEl12gxU6zENZ/4a4DV1HkxIHtpbh1qub1lhpGR41Z
        BXv+SQhwuMLFSNeuUjAAClC/g1pJ0gzI0ko1vcQFv+Q486jYY/kv+k4szzcB++nLILmYmgzOH0NE
        qT57XtdiBWhlb6oNfF/nYZAaToBU/QjtWXq3YImG2NiCUrCj9zAKHdGUsBU0FxN7HkVBB8aF0VYw
        B0I2LRO4Af6Ry1cqMyCQnw3FVh0xw7Vz4gQ57acUYeAJpT68q8E2XcUxriEP65/MBPoFlANLVMSr
        nsePEXmVzdysmXKnFVefeQ4E3dIDufXUIhrfmL1pMdTGanhmDEjY7I3pQQQIaLpnNhhSDZKDSk9C
        /Ax/8gEUgnnmd6BwZxh8Q7oDXcm2tyeun2m9wCZI/eJI9P9G8ON8AkKvG4xFR+eqhowwzu7TLDr3
        feliG+UN+mJ8jwARAQABzR5MYXVuY2hwYWQgUFBBIGZvciBNb3ppbGxhIFRlYW3CwY4EEwEKADgW
        IQRzi+uTIdGq7BPqk5GuvfSBm+IYZwUCZii/zgIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAK
        CRCuvfSBm+IYZ38/D/46eEIyG7Gb65sxt3QnlIN0+90kUjz83QpCnIyALZDcH2wPYBCMbyJFMG+r
        qVE8Yoh6WF0Rqy76LG+Y/xzO9eKIJGxVcSU75ifoq/M7pI1paiqA9T8QcFBmo83FFoPvnid67aqg
        /tFsHl+YF9rUxMZndGRE9Hk96lkH1Y2wHMEsmAa582RELVEDDD2ellOPmQr69fRPa5IdJHkXjqGt
        oNQy5hAp49ofMLmeQ82d2OA+kpzgiuSw8Nh1VrMZludcUArSQDCHoXuiPG/7Wn9Vy6fvKkTQK3mC
        W8i5HgCa0qxevOKlDMz4virEEADMBs79iIyM6w1xm8JOD4734sgii2MPcQgmAlbu5LyBM5FfuO0u
        rTMvZM0btSWQX3nIsxQ3far9MJvUT4nebhTo59cED+1EjkD14mReTHwtWt1aye/bI8Rvor15RFiB
        8Ku6c41YmNKarSCzJDs4VEfsos4oMieEqA98J4ZOX67IT++ortcBuXmDJgvzGWEeyVOMoc/4oDJH
        NQjJg9XRGy8b/J3AVhk2BE/CD4lKhX3hWGbufrQzE8ENWuT4m3igQnBmOsrGlBPYIOKZvczQxri0
        1vcKY95dKXb1jtnR9yR+JKgEP3881B/8dEohynhMnzEqR9TIMEEy9Y8RKZ+Jiy+/Lg2XGrChiLso
        uUetfMQww6BTK+++pw==



apt_firefox_config:
  file.managed:
    - name: /etc/apt/sources.list.d/mozillateam-ubuntu-ppa.list
    - mode: 0644
    - user: root
    - group: root
    - contents: |
        deb https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu/ {{ grains["lsb_distrib_codename"] }} main
        # deb-src https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu/ {{ grains["lsb_distrib_codename"] }} main

/etc/apt/sources.list.d/saltstack.list: file.absent
/etc/apt/sources.list.d/saltstack.sources: file.absent
/etc/apt/sources.list.d/salt.sources:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - contents: |
        X-Repolib-Name: Salt Project
        Description: Salt has many possible uses, including configuration management.
          Built on Python, Salt is an event-driven automation tool and framework to deploy,
          configure, and manage complex IT systems. Use Salt to automate common
          infrastructure administration tasks and ensure that all the components of your
          infrastructure are operating in a consistent desired state.
          - Website: https://saltproject.io
          - Public key: https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public
        Enabled: yes
        Types: deb
        URIs: https://packages.broadcom.com/artifactory/saltproject-deb
        Signed-By: /etc/apt/keyrings/salt-archive-keyring.pgp
        Suites: stable
        Components: main

{%- set zabbix_repo_files = salt["cmd.run"]("grep -rFlsa zabbix.repo.timeweb.ru /etc/apt/", ignore_retcode=True) %}
{%- if zabbix_repo_files %}
apt_timeweb_repo_absent:
  file.absent:
    - names:
  {%- for file in zabbix_repo_files.split("\n") %}
      - {{ file }}
  {%- endfor %}
{%- endif %}
