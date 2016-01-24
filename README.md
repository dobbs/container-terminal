Container Terminal
==================

Experiments in containerizing all the things

![a container crane with an aft view of an almost fully loaded container ship; six and seven layers of shipping containers visible on the deck.](http://dobbs.github.io/container-terminal/HHLA_Container_Terminal_Altenwerder.jpg)

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
