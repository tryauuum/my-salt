# what is this

it puts your computer in a predictable (to my taste) state\
in other words, this is a collection of [salt](https://github.com/saltstack/salt) states for managing my personal computers

# how to install

```
git clone https://github.com/tryauuum/my-salt /srv/salt/

curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | gpg --dearmor -o /etc/apt/keyrings/salt-archive-keyring.gpg
cat <<EOF > /etc/apt/sources.list.d/salt.sources
X-Repolib-Name: Salt Project
Enabled: yes
Types: deb
URIs: https://packages.broadcom.com/artifactory/saltproject-deb
Signed-By: /etc/apt/keyrings/salt-archive-keyring.gpg
Suites: stable
Components: main
EOF
apt update
apt-get install salt-minion=3007.1 --yes # later salt creates config to pin the version
```

then you can (periodically) run this thing when you want to apply state from this repo
```
salt-call state.apply --local
```

# limitations

* to keep everything easy to install, pillar is not used. due to that, code somewhat sucks
* again, to keep everything easy to install, no node roles or categories exist. because assining roles/categories to machines complicates installation
