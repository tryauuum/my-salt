# do not want salt-minion to connect to any master. we are running fully masterless
salt-minion_please_stay_dead:
  service.dead:
    - name: salt-minion
    - enable: False
