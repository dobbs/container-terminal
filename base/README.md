# Base Docker Images

### tini:0.9.0

includes UTF-8 locale setup and tini as the entrypoint

https://github.com/krallin/tini

```bash
docker build --tag=tini:0.9.0 --file=tini-Dockerfile .
```

### sshd:tini
```bash
docker build --tag=sshd:tini --file=sshd-Dockerfile .
```

### thewrongway

here's a Debian Jessie version:

```bash
docker build --tag=thewrongway:jessie --file=thewrongway-jessie-Dockerfile .
```

here's an Ubuntu Trusty version:

```bash
docker build --tag=thewrongway:trusty --file=thewrongway-trusty-Dockerfile .
```


Usage of these image (using Jessie for this example):

``` bash
# create a volume, mainly to persist the .ssh/authorized_keys
docker volume create --driver=local --name=home

# copy your public key into the deploy user's authorized_keys
<~/.ssh/id_rsa.pub docker run --rm -it -v"home:/home/deploy" \
  thewrongway:jessie tee /home/deploy/.ssh/authorized_keys

# start the container in deamonized mode
docker run -d --port="2200:22" --name=jessie thewrongway:jessie

# make sure sshd is running inside that contianer
docker exec -it jessie
# service ssh start
# exit

# confirm that you can ssh into the container
# setting $DOCKER_HOST_IP_ADDRESS is left as an exercise for the reader
ssh -p 2200 deploy@$DOCKER_HOST_IP_ADDRESS

# within the container, confirm you have passwordless sudo
$ sudo pwd
```

Now you can test all your legacy system admin things with that deploy user.
