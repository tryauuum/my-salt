# FIXME maybe you shoud manage system-wide vimrc in /etc/vim ?
rcfiles_vimrc_root:
  file.managed:
    - names:
      - /root/.vimrc
    - mode: 0600
    - user: root
    - group: root
    - source: salt://{{ tpldir }}/files/vimrc

{%- if grains['unprivileged_user'] %}
rcfiles_sqliterc_{{ grains['unprivileged_user'] }}:
  file.managed:
    - names:
      - /home/{{ grains['unprivileged_user'] }}/.sqliterc
    - mode: 0600
    - user: {{ grains['unprivileged_user'] }}
    - group: {{ grains['unprivileged_user'] }}
    - source: salt://{{ tpldir }}/files/sqliterc

rcfiles_vimrc_{{ grains['unprivileged_user'] }}:
  file.managed:
    - names:
      - /home/{{ grains['unprivileged_user'] }}/.vimrc
    - mode: 0600
    - user: {{ grains['unprivileged_user'] }}
    - group: {{ grains['unprivileged_user'] }}
    - source: salt://{{ tpldir }}/files/vimrc

rcfiles_bashrc_{{ grains['unprivileged_user'] }}:
  file.managed:
    - names:
      - /home/{{ grains['unprivileged_user'] }}/.bashrc
    - mode: 0600
    - user: {{ grains['unprivileged_user'] }}
    - group: {{ grains['unprivileged_user'] }}
    - source: salt://{{ tpldir }}/files/bashrc

# this is to make sure I migrated all machines to new aliases
rcfiles_remove_aliases:
  file.absent:
    - name: /home/{{ grains['unprivileged_user'] }}/.bash_aliases

rcfiles_xfce-terminal_{{ grains['unprivileged_user'] }}:
  file.recurse:
    - name: /home/{{ grains['unprivileged_user'] }}/.config/xfce4/terminal/
    - source: salt://{{ tpldir }}/files/terminal/
    - user: {{ grains['unprivileged_user'] }}
    - group: {{ grains['unprivileged_user'] }}
    - dir_mode: 0700
    - file_mode: 0600
{%- endif %}

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
