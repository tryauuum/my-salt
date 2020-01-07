atop_pkg_installed:
  pkg.installed:
    - name: atop

atop_service_running:
  service.running:
    - name: atop
    - require:
      - pkg: atop_pkg_installed

# xenial only
atop_default_xenial:
  file.replace:
    - name: /etc/default/atop
    - pattern: '^INTERVAL=.*$'
    - repl: 'INTERVAL=60'
    - append_if_not_found: True
    - require:
      - pkg: atop_pkg_installed
    - watch_in:
      - service: atop_service_running

