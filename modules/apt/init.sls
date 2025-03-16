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

/etc/apt/keyrings/salt-archive-keyring.pgp:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - contents: |
        -----BEGIN PGP PUBLIC KEY BLOCK-----

        mQGNBGPazmABDAC6qc2st6/Uh/5AL325OB5+Z1XMFM2HhQNjB/VcYbLvcCx9AXsU
        eaEmNPm6OY3p5+j8omjpXPYSU7DUQ0lIutuAtwkDMROH7uH/r9IY7iu88S6w3q89
        bgbnqhu4mrSik2RNH2NqEiJkylz5rwj4F387y+UGH3aXIGryr+Lux9WxfqoRRX7J
        WCf6KOaduLSp9lF4qdpAb4/Z5yExXtQRA9HULSJZqNVhfhWInTkVPw+vUo/P9AYv
        mJVv6HRNlTb4HCnl6AZGcAYv66J7iWukavmYKxuIbdn4gBJwE0shU9SaP70dh/LT
        WqIUuGRZBVH/LCuVGzglGYDh2iiOvR7YRMKf26/9xlR0SpeU/B1g6tRu3p+7OgjA
        vJFws+bGSPed07asam3mRZ0Y9QLCXMouWhQZQpx7Or1pUl5Wljhe2W84MfW+Ph6T
        yUm/j0yRlZJ750rGfDKA5gKIlTUXr+nTvsK3nnRiHGH2zwrC1BkPG8K6MLRluU/J
        ChgZo72AOpVNq9MAEQEAAbQ5U2FsdCBQcm9qZWN0IFBhY2thZ2luZyA8c2FsdHBy
        b2plY3QtcGFja2FnaW5nQHZtd2FyZS5jb20+iQHSBBMBCAA8FiEEEIV//dP5Hq5X
        eiHWZMu8gXPXaz8FAmPazmACGwMFCwkIBwIDIgIBBhUKCQgLAgQWAgMBAh4HAheA
        AAoJEGTLvIFz12s/yf0L/jyP/LfduA4DwpjKX9Vpk26tgis9Q0I54UerpD5ibpTA
        krzZxK1yFOPddcOjo+Xqg+I8aA+0nJkf+vsfnRgcpLs2qHZkikwZbPduZwkNUHX7
        6YPSXTwyFlzhaRycwPtvBPLFjfmjjjTi/aH4V/frfxfjH/wFvH/xiaiFsYbP3aAP
        sJNTLh3im480ugQ7P54ukdte2QHKsjJ3z4tkjnu1ogc1+ZLCSZVDxfR4gLfE6GsN
        YFNd+LF7+NtAeJRuJceXIisj8mTQYg+esTF9QtWovdg7vHVPz8mmcsrG9shGr+G9
        iwwtCig+hAGtXFAuODRMur9QfPlP6FhJw0FX/36iJ2p6APZB0EGqn7LJ91EyOnWv
        iRimLLvlGFiVB9Xxw1TxnQMNj9jmB1CA4oNqlromO/AA0ryh13TpcIo5gbn6Jcdc
        fD4Rbj5k+2HhJTkQ78GpZ0q95P08XD2dlaM2QxxKQGqADJOdV2VgjB2NDXURkInq
        6pdkcaRgAKme8b+xjCcVjLkBjQRj2s5gAQwAxmgflHInM8oKQnsXezG5etLmaUsS
        EkV5jjQFCShNn9zJEF/PWJk5Df/mbODj02wyc749dSJbRlTY3LgGz1AeywOsM1oQ
        XkhfRZZqMwqvfx8IkEPjMvGIv/UI9pqqg/TY7OiYLEDahYXHJDKmlnmCBlnU96cL
        yh7a/xY3ZC20/JwbFVAFzD4biWOrAm1YPpdKbqCPclpvRP9N6nb6hxvKKmDo7MqS
        uANZMaoqhvnGazt9n435GQkYRvtqmqmOvt8I4oCzV0Y39HfbCHhhy64HSIowKYE7
        YWIujJcfoIDQqq2378T631BxLEUPaoSOV4B8gk/Jbf3KVu4LNqJive7chR8F1C2k
        eeAKpaf2CSAe7OrbAfWysHRZ060bSJzRk3COEACk/UURY+RlIwh+LQxEKb1YQueS
        YGjxIjV1X7ScyOvam5CmqOd4do9psOS7MHcQNeUbhnjm0TyGT9DF8ELoE0NSYa+J
        PvDGHo51M33s31RUO4TtJnU5xSRb2sOKzIuBABEBAAGJAbYEGAEIACAWIQQQhX/9
        0/kerld6IdZky7yBc9drPwUCY9rOYAIbDAAKCRBky7yBc9drP8ctC/9wGi01cBAW
        BPEKEnfrKdvlsaLeRxotriupDqGSWxqVxBVd+n0Xs0zPB/kuZFTkHOHpbAWkhPr+
        hP+RJemxCKMCo7kT2FXVR1OYej8Vh+aYWZ5lw6dJGtgo3Ebib2VSKdasmIOI2CY/
        03G46jv05qK3fP6phz+RaX+9hHgh1XW9kKbdkX5lM9RQSZOof3/67IN8w+euy61O
        UhNcrsDKrp0kZxw3S+b/02oP1qADXHz2BUerkCZa4RVK1pM0UfRUooOHiEdUxKKM
        DE501hwQsMH7WuvlIR8Oc2UGkEtzgukhmhpQPSsVPg54y9US+LkpztM+yq+zRu33
        gAfssli0MvSmkbcTDD22PGbgPMseyYxfw7vuwmjdqvi9Z4jdln2gyZ6sSZdgUMYW
        PGEjZDoMzsZx9Zx6SO9XCS7XgYHVc8/B2LGSxj+rpZ6lBbywH88lNnrm/SpQB74U
        4QVLffuw76FanTH6advqdWIqtlWPoAQcEkKf5CdmfT2ei2wX1QLatTs=
        =ZKPF
        -----END PGP PUBLIC KEY BLOCK-----

{%- set zabbix_repo_files = salt["cmd.run"]("grep -rFlsa zabbix.repo.timeweb.ru /etc/apt/", ignore_retcode=True) %}
{%- if zabbix_repo_files %}
apt_timeweb_repo_absent:
  file.absent:
    - names:
  {%- for file in zabbix_repo_files.split("\n") %}
      - {{ file }}
  {%- endfor %}
{%- endif %}
