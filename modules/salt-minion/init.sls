# do not want salt-minion to connect to any master. we are running fully masterless
salt-minion_please_stay_dead:
  service.dead:
    - name: salt-minion
    - enable: False

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
