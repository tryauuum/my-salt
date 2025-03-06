# do not want salt-minion to connect to any master. we are running fully masterless
salt-minion_please_stay_dead:
  service.dead:
    - name: salt-minion
    - enable: False

salt-minion_config:
  file.managed:
    - name: /etc/salt/minion
    - user: root
    - group: root
    - mode: 0644
    - contents: |
        master_type: disable
        state_verbose: False

/etc/apt/preferences.d/salt-pin-1001:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - contents: |
        Package: salt-*
        Pin: version 3007.*
        Pin-Priority: 1001

/srv/salt/.git/config:
  file.managed:
    - user: root
    - group: root
    - mode: 0600
    - contents: |
        [core]
            repositoryformatversion = 0
            filemode = true
            bare = false
            logallrefupdates = true
        [remote "origin"]
            url = https://github.com/tryauuum/my-salt
            fetch = +refs/heads/*:refs/remotes/origin/*
            pushurl = git@github.com:tryauuum/my-salt.git
        [branch "master"]
            remote = origin
            merge = refs/heads/master
        [user]
            name = tryauuum
            email = 43639775+tryauuum@users.noreply.github.com
