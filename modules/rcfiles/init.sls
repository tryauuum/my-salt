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
