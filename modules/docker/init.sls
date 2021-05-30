# I do not want docker to turn my machine into a fucking router
docker_config:
  file.serialize:
    - name: /etc/docker/daemon.json
    - dataset:
        bridge: "none"
        iptables: False
        ip-forward: False
    - serializer: json
    - user: root
    - group: root
    - perms: 0600
  service.running:
    - name: docker
    - enable: True
    - watch:
      - file: docker_config
