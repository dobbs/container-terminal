Container Terminal
==================

Experiments in containerizing all the things

![a container crane with an aft view of an almost fully loaded container ship; six and seven layers of shipping containers visible on the deck.](http://dobbs.github.io/container-terminal/HHLA_Container_Terminal_Altenwerder.jpg)

Notes to Self
=============

Documenting what I learn in detailed commit messages.  So
might find this link helpful.

https://github.com/dobbs/container-terminal/commits/master

The Core Mechanic
=================

Containers excel at wrapping a single *process* with a complete and
predictable environment.  Processes themselves come in two flavors:
single-use commands and long-running, daemonized services.  After some
initial experimentation, I'm settling in on a common organizational
pattern and common usage pattern for experiments in containing
processes.

The general pattern creates a container image and a container volume
which I can use for both kinds of processes.  In one invokation, I
launch the daemonized service.  In other invoations I use the same
configuration to create single-use containers which share the
supporting container volume.  The single-use commands allow
modification of the files and folders used by the deamonized service.

The `git` experiment will serve as a representative example to explain
the patterns.  The experiment wraps sshd into a specialized git
server.  With a `docker-compose.yml` file, I define a container and a
related volume for the container's persistent storage.

It's a simple service, with a correspondingly simple file structure:

```
git/
  Dockerfile
  docker-compose.yml
```

Even the `docker-compose.yml` is pretty simple:

```
version: '2'

services:
  server:
    build: .
    ports:
      - "2200:22/tcp"
    volumes:
      - server:/home/git

volumes:
  server:
    driver: local
```

Dockerfile holds a bit more complexity, but essentially creates a git
user and runs sshd.

Here's the invokation that launches the long-running process:
```bash
$ docker-compose up -d
```

The next invokation uses a single-use container to set up ssh
credentials for use by the long-running process:

```bash
$ ssh-keygen -t ed25519 -b 384
$ <~/.ssh/id_ed25519.pub docker-compose run --user git --rm git tee .ssh/authorized_keys
```

Here I can verify that they're working:

```bash
$ export DOCKER_HOST_IP=$(awk -F'[:/]' '{print $4}' <<<"$DOCKER_HOST")
$ ssh -i ~/.ssh/id_ed25519 -p 2200 git@$DOCKER_HOST_IP
```

And apply a couple more single-use processes to actually use the git
service as a remote git repository

```bash
$ git clone --bare . ~/tmp/container-terminal.git
$ tar c -C ~/tmp containter-terminal.git | docker-compose run --user git --rm git tar x
$ git remote add local ssh://git@$DOCKER_HOST_IP:2200/~/container-terminal.git
$ git fetch local
```

With a combination of `Dockerfile` and `docker-compose.yml` I can
create little containerized digital ecosystems for experimenting with
all manner of new tools and languages and technologies.  Combining
container volumes with daemonized processes and single-use processes I
can explore the digital ecosystems and gradually build up an
understanding of how to connect and coordinate and orchestrate them.

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
