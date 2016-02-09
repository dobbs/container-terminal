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

## git and gitrun ##

The gitrun service will quickly become one of my favorite new tricks.
Basically, it enables easy modification of the filesystem of the
primary git service.

Setting up ssh credentials
```bash
$ ssh-keygen -t ed25519 -b 384
$ <~/.ssh/id_ed25519.pub docker-compose run --rm gitrun bash -c 'cat >> .ssh/authorized_keys && chmod 600 .ssh/authorized_keys'
$ ssh -i ~/.ssh/id_ed25519 -p 2200 git@$DOCKER_HOST_IP
```

Proof of concept for copying a repository to the service:
```bash
$ git clone --bare . ~/tmp/container-terminal.git
$ tar c -C ~/tmp containter-terminal.git | docker-compose run --rm gitrun tar x
$ git remote add local ssh://git@$DOCKER_HOST_IP:2200/~/container-terminal.git
$ git fetch local
```


Sad Panda
=========

Most recent docker toolbox, as of 2016-02 includes a docker-compose
that is broken on Late 2010 MacBook Air.

https://github.com/docker/compose/issues/1885

The advertised work around did work for me:
```bash
brew install python
pip install docker-compose
```
