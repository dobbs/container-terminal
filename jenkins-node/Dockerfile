FROM jenkins:1.642.2

USER root
RUN apt-get update \
 && apt-get install -y --no-install-recommends openssh-server \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir /var/run/sshd \
 && printf "%s\n"\
  "UseDNS no"\
  "PasswordAuthentication no"\
  "ChallengeResponseAuthentication no"\
  "PermitRootLogin no"\
  >> /etc/ssh/sshd_config \
 && mkdir "$JENKINS_HOME/.ssh" \
 && chown jenkins:jenkins "$JENKINS_HOME/.ssh" \
 && chmod -R 700 "$JENKINS_HOME/.ssh"
ENTRYPOINT ["/bin/tini", "--"]
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
