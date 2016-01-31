FROM krallin/ubuntu-tini:trusty
MAINTAINER Eric Dobbs <eric@dobbse.net>

RUN apt-get update \
 && apt-get install -y openssh-server git bash curl \
 && mkdir /var/run/sshd
RUN printf "%s\n"\
 "UseDNS no"\
 "PasswordAuthentication no"\
 "ChallengeResponseAuthentication no"\
 "PermitRootLogin no"\
 >> /etc/ssh/sshd_config
RUN addgroup git \
 && adduser --disabled-password --shell=/usr/bin/git-shell --home=/home/git --ingroup=git \
    --gecos="git access" git \
 && mkdir /home/git/.ssh && chown git:git /home/git/.ssh && chmod -R 700 /home/git
VOLUME /home/git

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
