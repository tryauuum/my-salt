# what is this

it puts your computer in a predictable (to my taste) state\
in other words, this is a collection of [salt](https://github.com/saltstack/salt) states for managing my personal computers

# how to install

```
git clone https://github.com/tryauuum/my-salt /srv/salt/
curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public > /etc/apt/keyrings/salt-archive-keyring.pgp
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources > /etc/apt/sources.list.d/salt.sources
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
