FROM alpine:3.4
RUN apk --no-cache add dnsmasq drill curl ca-certificates
EXPOSE 53 53/udp
ENV CP 2.1.2
ENV CP_SHA1 "c31333047d58ba09d647d717ae1fc691133db6eb  /tmp/containerpilot.tar.gz"
ENV CP_URL "https://github.com/joyent/containerpilot/releases/download/${CP}/containerpilot-${CP}.tar.gz"
RUN echo -e "downloading $CP_URL\ncomparing with $CP_SHA1" \
 && curl -Lso /tmp/containerpilot.tar.gz "$CP_URL" \
 && echo "${CP_SHA1}" | sha1sum -c \
 && tar zxf /tmp/containerpilot.tar.gz -C /bin \
 && rm /tmp/containerpilot.tar.gz
COPY containerpilot.json /etc/containerpilot.json
CMD ["containerpilot", "-config", "file:///etc/containerpilot.json", \
  "dnsmasq", "-k", "--address=/swim/192.168.99.100"]
