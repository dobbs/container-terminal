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
