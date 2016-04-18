FROM centurylink/golang-builder:latest
RUN mv /build_environment.sh /orig_build_environment.sh
COPY /build_environment.sh /build_environment.sh
ENV OUTPUT=vault-command
COPY Dockerfile-vault /src/Dockerfile
CMD ["local/vault:0.5.2"]
