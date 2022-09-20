# what is this

it puts your computer in a predictable (to my taste) state\
in other words, this is a collection of [salt](https://github.com/saltstack/salt) states for managing my personal computers

# how to install

initial setup is easy\
even though there's `20.04` in repo URL, instructions work for both 20.04 and 22.04
```
git clone https://github.com/tryauuum/my-salt /srv/salt/
wget -O - https://repo.saltstack.com/py3/ubuntu/20.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
echo 'deb [arch=amd64] http://repo.saltstack.com/py3/ubuntu/20.04/amd64/latest focal main' > /etc/apt/sources.list.d/saltstack.list
apt update
apt-get install salt-minion --yes
```

then you can (periodically) run this thing when you want to apply state from this repo
```
salt-call state.apply --local
```

# limitations

* to keep everything easy to install, pillar is not used. due to that, code somewhat sucks
* again, to keep everything easy to install, no node roles or categories exist. because assining roles/categories to machines complicates installation
