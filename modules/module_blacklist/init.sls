{% set fucking_module = 'snd_hda_codec_hdmi' %}
module_blacklist_fuck_hdmi_output:
  file.managed:
    - name: /etc/modprobe.d/salt.conf
    - user: root
    - group: root
    - mode: 0644
    - contents: |
        blacklist {{ fucking_module }}

module_blacklist_fail_if_loaded:
  test.fail_without_changes:
    - name: module {{ fucking_module }} is not unloaded, please reboot
    - failhard: False
    - onlyif: lsmod | grep -qw {{ fucking_module }}
