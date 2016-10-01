FROM alpine:3.4
RUN apk --no-cache add dnsmasq drill curl ca-certificates unzip
EXPOSE 53 53/udp
ENV CP 2.1.2
ENV CP_SHA1 "c31333047d58ba09d647d717ae1fc691133db6eb  /tmp/containerpilot.tar.gz"
ENV CP_URL "https://github.com/joyent/containerpilot/releases/download/${CP}/containerpilot-${CP}.tar.gz"
ENV CT 0.16.0
ENV CT_SHA1 "064b0b492bb7ca3663811d297436a4bbf3226de706d2b76adade7021cd22e156  /tmp/consul-template.zip"
ENV CT_URL "https://releases.hashicorp.com/consul-template/${CT}/consul-template_${CT}_linux_amd64.zip"
RUN echo -e "downloading ${CT_URL}\ncomparing with ${CT_SHA1}" \
 && curl --retry 7 --fail -Lso /tmp/consul-template.zip "${CT_URL}" \
    && echo "${CT_SHA1}" | sha256sum -c \
    && unzip /tmp/consul-template.zip -d /bin \
    && rm /tmp/consul-template.zip
RUN echo -e "downloading ${CP_URL}\ncomparing with ${CP_SHA1}" \
 && curl -Lso /tmp/containerpilot.tar.gz "$CP_URL" \
 && echo "${CP_SHA1}" | sha1sum -c \
 && tar zxf /tmp/containerpilot.tar.gz -C /bin \
 && rm /tmp/containerpilot.tar.gz
COPY containerpilot.json /etc/containerpilot.json
COPY health.sh /usr/local/bin/
CMD ["containerpilot", "-config", "file:///etc/containerpilot.json", \
  "dnsmasq", "-k", "--address=/swim/192.168.99.100"]
