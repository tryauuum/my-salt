# FIXME maybe you shoud manage system-wide vimrc in /etc/vim ?
rcfiles_vimrc_root:
  file.managed:
    - names:
      - /root/.vimrc
    - mode: 0600
    - user: root
    - group: root
    - source: salt://{{ tpldir }}/files/vimrc

rcfiles_vimrc_tryauuum:
  file.managed:
    - names:
      - /home/tryauuum/.vimrc
    - mode: 0600
    - user: tryauuum
    - group: tryauuum
    - source: salt://{{ tpldir }}/files/vimrc

rcfiles_xfce-terminal_tryauuum:
  file.recurse:
    - name: /home/tryauuum/.config/xfce4/terminal/
    - source: salt://{{ tpldir }}/files/terminal/
    - user: tryauuum
    - group: tryauuum
    - dir_mode: 0700
    - file_mode: 0600
