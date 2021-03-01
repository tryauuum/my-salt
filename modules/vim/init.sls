vim_salt_syntax:
  file.recurse:
    - clean: False
    - dir_mode: 0755
    - file_mode: 0644
    - name: /etc/vim
    - source: salt://{{ tpldir }}/files/vim/
