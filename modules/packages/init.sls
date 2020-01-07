{% set packages_install = ['vim',
                           'curl',
                           'screen',
                           'htop',
                           ] %}

{% set packages_purge = ['snapd',
                         'pidgin',
                         'mlocate',
                         'os-prober',
                         ] %}

packages_install:
  pkg.installed:
    - pkgs:
      {%- for p in packages_install %}
      - {{ p }}
      {%- endfor %}

packages_purge:
  pkg.purged:
    - pkgs:
      {%- for p in packages_purge %}
      - {{ p }}
      {%- endfor %}
