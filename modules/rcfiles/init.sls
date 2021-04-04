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

rcfiles_bashrc_tryauuum:
  file.managed:
    - names:
      - /home/tryauuum/.bashrc
    - mode: 0600
    - user: tryauuum
    - group: tryauuum
    - source: salt://{{ tpldir }}/files/bashrc

# this is to make sure I migrated all machines to new aliases
rcfiles_remove_aliases:
  file.absent:
    - name: /home/tryauuum/.bash_aliases

rcfiles_xfce-terminal_tryauuum:
  file.recurse:
    - name: /home/tryauuum/.config/xfce4/terminal/
    - source: salt://{{ tpldir }}/files/terminal/
    - user: tryauuum
    - group: tryauuum
    - dir_mode: 0700
    - file_mode: 0600

# not really an rc-file
rcfiles_unfuck_default_editor:
  file.managed:
    - name: /etc/environment
    - mode: 0644
    - user: root
    - group: root
    - contents: |
        PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
        EDITOR="vim"
