Jenkins nodes need java, sshd, an ssh account for the jenkins server, and authorized_keys correctly configured.

Here are the commands I've used to get a server and node running and talking to one another.

```bash
ct jenkins run --rm server ssh-keygen -t rsa -b 4096 

ct jenkins run --rm server cat /var/jenkins_home/.ssh/id_rsa.pub
| ct jenkins run --rm --user jenkins node tee /var/jenkins_home/.ssh/authorized_keys

ipaddr=$(ct jenkins ps -q node | xargs docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}')
```

With the keys generated and the server authorized to login to the node, the jenkins server UI can be used to configure a credential and then use that credential for setting up the jenkins node.
