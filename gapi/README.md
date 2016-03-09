This experiment combines Docker and Docker Compose with coffescript to explore Google Drive APIs.

First, add `bin` to $PATH to enable our `ct` command:

```
PATH=$(pwd)/bin:$PATH
```

Second, build the Docker image that our `gapi` service needs:

```
docker-compose --file coffee.yml build
```

Google offers a Node.js Quickstart which I'm modifying in a few ways:
https://developers.google.com/drive/v3/web/quickstart/nodejs

Follow step 1 to set up your own developer account and download `client_secret.json`.  Then put it in your container volume:

```
<client_secret.json ct gapi tee client_secret.json > /dev/null
```

Maybe worth a diversion to explain what just happened.  `ct` is just a wrapper around `docker-compose` to reduce the amount we have to type.  The above expands to:

```
<client_secret.json docker-compose --file gapi.yml run --rm gapi tee client_secret.json > /dev/null
```

We use a standard shell input redirection to put the contents of `client_secret.json` into STDIN for `docker-compose`.  `gapi.yml` maps a container volume into the Docker WORKDIR.  And the command we pass to the container uses `tee` to write STDIN to a file named `client_secret.json` in the WORKDIR inside the container.  Because WORKDIR is mapped to the container volume, the `client_secret.json` will persist between runs of `docker-compose`.  In effect, we've used plain old shell tricks to copy files into container volume.  I'm sure there are other ways to do it, but we're going to be using similar tricks in the steps to follow, so understanding this example may be helpful.

Returning to the quickstart, run these two, slightly modified commands
from step 2:

```
ct gapi npm install googleapis --save
ct gapi npm install google-auth-library --save
```

As a slight diversion, confirm that those commands are getting persisted inside the container volume.  Run this command:

```
ct gapi cat package.json
```

At the bottom of the output from that command you should see this:
```
"dependencies": {
 "coffee-script": "^1.10.0",
 "google-auth-library": "^0.9.7",
 "googleapis": "^2.1.7"
}
```

That persistance is one of the reasons Docker Compose is cool and it's basically the same mechanism I described when copying `client_secret.json` into the container above.  It's a pretty light bit of configuration to create a container volume and a service which uses the container volume for persistent storage.  Taking the time to really understand how this works, this aspect of Docker Compose, has been one of the most helpful ways for me to get my own head around Docker and how to apply containerization to my own software puzzles.

Returning again to the quickstart, I have ported their sample to `quickstart.coffee`, just slightly modified to use the `/usr/src/app` folder that our container uses as its WORKDIR.

We use the by-now-familiar trick to copy that file into the container volume:

```
<gapi/quickstart.coffee ct gapi tee quickstart.coffee
```

For step 4 of the quickstart, run this command:

```
cg gapi coffee quickstart.coffee
```

The first time through step 4, the quickstart guides you to take a few steps with your web browser to permit this little program to access data about your own Google Drive account.  But it's worth running it a second time to notice that the permission you just granted gets persisted in the container volume too.

As a further exercise in exploring Docker, try the commad below to poke around inside the container.  You can test the persistance inside the container by creating files both inside and outside of `/usr/src/app`.  Then exit the shell within and re-enter it and see which files are there the second time around.

```
ct gapi bash
```

This still feels like early days in my own learning curve for containerization.  But one of the things I like, so far, is thinking about what parts of the filesystem I want to perist and where I want the container to reset itself to a clean state.
