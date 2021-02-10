# my-salt

salt states for managing my personal computers

initial setup is easy

```
git clone git@github.com:tryauuum/my-salt.git /srv/salt/
wget -O - https://repo.saltstack.com/py3/ubuntu/20.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
echo 'deb http://repo.saltstack.com/py3/ubuntu/20.04/amd64/latest focal main' > /etc/apt/sources.list.d/saltstack.list
apt update
apt-get install salt-minion --yes
```

and then you can run this thing to apply state from this repo
```
salt-call state.apply --local
```

# limitations

to keep everything easy to install, pillar is not used. due to that, code somewhat sucks
