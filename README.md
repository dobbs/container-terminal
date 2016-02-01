Container Terminal
==================

Experiments in containerizing all the things

![a container crane with an aft view of an almost fully loaded container ship; six and seven layers of shipping containers visible on the deck.](http://dobbs.github.io/container-terminal/HHLA_Container_Terminal_Altenwerder.jpg)

Notes to Self
=============

Documenting what I learn in detailed commit messages.  So
might find this link helpful.

https://github.com/dobbs/container-terminal/commits/master

Usage
=====

```bash
# Need some environment variables to make docker and docker-compose work
$ eval $(docker-machine env default)

# Using dnsmasq to control fake domain names.  Using $DOMAIN to
# specify our fake domain name, and calculating the docker host's IP
# address from $DOCKER_HOST
$ export DOMAIN=bogus  
$ export DOCKER_HOST_IP=$(awk -F'[:/]' '{print $4}' <<<"$DOCKER_HOST")

# Come Sail Away!
$ docker-compose up -d

# See if DNS is working
$ [[ "$DOCKER_HOST_IP" == "$(dig +short @$DOCKER_HOST_IP wat.$DOMAIN)" ]]
$ [[ $? -eq 0 ]] && echo BING || echo SAD_TROMBONE
```

# Serivces #

## git ##

Setting up ssh credentials
```
$ ssh-keygen -t ed25519 -b 384
$ <~/.ssh/id_ed25519.pub docker run --rm -i --user=git --volumes-from=containerterminal_git_1 containerterminal_git bash -c 'cat >> /home/git/.ssh/authorized_keys && chmod 600 /home/git/.ssh/authorized_keys'
$ ssh -i ~/.ssh/id_ed25519 -p 2200 git@$DOCKER_HOST_IP
```

Proof of concept for copying a repository to the service:
```
$ git clone --bare . ~/tmp/container-terminal.git
$ tar c -C ~/tmp containter-terminal.git | docker run --rm -i -w
/home/git -u git --volumes-from=containterterminal_git_1 containerterminal_git tar x
$ git remote add local ssh://git@$DOCKER_HOST_IP:2200/~/container-terminal.git
$ git fetch local
```
