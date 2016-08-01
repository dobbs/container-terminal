# Jenkins 2.7.1

Includes base list of plugins, a default admin account, and a handy
wrapper around jenkins-cli.jar

``` shell
docker-compose up -d server
docker-compose logs server
# wait until you see the server has initialized
docker-compose run --rm server cli login --username admin --password password
docker-compose run --rm server cli list-plugins
docker-compose run --rm server cli groovysh
```
