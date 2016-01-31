FROM debian:jessie
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

RUN curl -L https://github.com/joyent/containerbuddy/releases/download/0.0.5/containerbuddy-0.0.5.tar.gz | tar zx -C /usr/local/bin

ADD git.json /usr/local/share/git.json
ADD git-health-check.sh /usr/local/bin/git-health-check.sh
EXPOSE 22
CMD ["/usr/local/bin/containerbuddy", \
 "-config", "file:///usr/local/share/git.json", \
 "/usr/sbin/sshd", "-d"]
