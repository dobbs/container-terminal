# Experimenting with HashiCorp's Vault

In the past couple years as I've taken a run at various devops projects, secrets are frequently an early hurdle that trips me up.  Deadline pressure competes with the need to slow down and think carefully about security and managing secrets.

A couple weeks ago I finally started looking at [HashiCorp's Vault](https://www.vaultproject.io) project and have to say it gives a very good first impression.  It is quite clearly a tool that's seen some careful thinking.

The discussion here persuated me to try CenturyLinkLabs golang-builder https://github.com/hashicorp/vault/issues/165#issuecomment-154115742

But this ended up somewhat convoluted.

golang-builder's shell scripts expect the source to be volume mounted.  But I wanted to download the source from a github release.  So I ended up hacking a script in front of golang-builder's code which downloads and unpacks the source code.

Anyway... usage for the moment:

Build the docker image with vault 0.5.2 inside it thusly:
```bash
docker-compose run --rm builder
```

Then run the vault command like so:
```bash
docker-compose run --rm vault
```

