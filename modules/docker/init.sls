docker_config:
  file.serialize:
    - name: /etc/docker/daemon.json
    - dataset:
        log-driver: "local"
    - serializer: json
    - user: root
    - group: root
    - perms: 0600
  service.running:
    - name: docker
    - enable: True
    - watch:
      - file: docker_config
