# Base Docker Images

I have enough experiments now to get a sense of what I want in my base
images.

First one is utf8tini which sets up the locale to UTF-8 and installs tini

```bash
docker build --tag=tini:0.9.0 --file=tini-Dockerfile .
```
