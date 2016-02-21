FROM buildpack-deps:jessie
MAINTAINER Eric Dobbs <eric@dobbse.net>

ENV TINI_VERSION v0.9.0
RUN apt-get update \
 && apt-get install -y --no-install-recommends openssh-server \
 && rm -rf /var/lib/apt/lists/*
 && mkdir /var/run/sshd \
 && printf "%s\n"\
  "UseDNS no"\
  "PasswordAuthentication no"\
  "ChallengeResponseAuthentication no"\
  "PermitRootLogin no"\
  >> /etc/ssh/sshd_config \
 && addgroup git \
 && adduser --disabled-password --shell=/usr/bin/git-shell --home=/home/git --ingroup=git \
    --gecos="git access" git \
 && mkdir /home/git/.ssh && chown git:git /home/git/.ssh && chmod -R 700 /home/git \
 && curl -Lo /tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini\
 && curl -Lo /tini.asc https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc\
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 0527A9B7 \
 && gpg --verify /tini.asc \
 && chmod +x /tini
ENTRYPOINT ["/tini", "--"]
VOLUME /home/git

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
