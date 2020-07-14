# Example of a simple Node/Express app that can be run in a container

This is just a super simple Node/Express app, but it comes with a `Dockerfile` that you can use to build a Docker image, and then run the app from a Docker container.

## Running the Node app without Docker

The point of this repo is to showcase how you can run your app in the isolated and portable setup of a container. But it's still just a simple Node/Express app, so you can also just run it with `node server.js`, provided you first install the dependencies with `npm install` of course.

## Building the Docker image

The first step is to build an "image" of your app. A Docker "image" is a blueprint for future containers that contain your app. (If you think of a container as a (virtual) computer, then the "image" is like the installation DVD that contains the OS for the computer.)

```bash
docker build -t example-containerized-api .
```

Note that although this will take quite some time the first time around, any subsequent build will be much shorter because Docker caches intermediate steps.

## Running a container

Now that we have an "image", we can start up a container (a virtual computer) from that blueprint:

```bash
docker run -p 4000:4000 -d example-containerized-api
```

Now you should be able to go to `http://localhost:4000` in your browser, and see the app!

Let's break this command down into pieces:

- `docker` -- duhh, we're working with Docker :D
- The `run example-containerized-api` sub-command tells Docker we want to start up a new container from the image called "example-containerized-api"
- The `-p 4000:4000` "flag" tells Docker that, although the container is supposed to run almost entirely in isolation (cut off from the rest of the world), we _do_ want to be able to talk to it through the port `4000`. So we're mapping _our port 4000_ (the left hand side) to _its port 4000_ (the right hand side). We could just as well have run `-p 15582:4000`, by the way, then we could have seen our app live at `http://localhost:15582`.
- The `-d` "flag" tells Docker that we don't want to receive all the output (the console.logs etc.) of the app in our terminal. Instead, we run it "in the background", as a "daemon".

We can also use Docker to check that the container is indeed up and running:

```bash
docker ps
```

This command should show something like:

```
CONTAINER ID        IMAGE                       COMMAND                  CREATED             STATUS              PORTS                      NAMES
714d8fac35a8        example-containerized-api       "docker-entrypoint.s…"   6 minutes ago       Up 6 minutes        0.0.0.0:4000->4000/tcp     quizzical_burnell
```

Apparently, that container has the ID `714d8fac35a8`. Just like a normal computer, you can stop it, start it again, remove it (i.e. throw it away), etc. We can do so with commands like so:

```bash
docker stop 714d8fac35a8
docker start 714d8fac35a8
```

Using `stop` is like pressing the "off" button of the computere. But if the off button doesn't work, we can always just yank the power cable out:

```bash
docker kill 714d8fac35a8
```

Finally, we can also just throw it away:

```bash
docker rm 714d8fac35a8
```

## Deploying the app with Heroku

### Using the Heroku CLI tool

First, if you haven't done so already, install the Heroku CLI tool:

https://devcenter.heroku.com/articles/heroku-cli

Then, make sure you have an account, and are logged in with the CLI tool:

```bash
heroku login
```

Also make sure this works:

```bash
heroku container:login
```

### Pushing the Docker image to the Heroku image registry

```bash
heroku container:push web
```

This command will build your image, just like we did above, and then immediately afterwards upload it to the Heroku image registry

### Then, you can deploy the app on Heroku

This will make a container of your most recently uploaded image in the Heroku image registry

```bash
heroku container:release web
```

If you forgot what the URL of your Heroku app is, or you're too lazy to go and find it, you can also run this command to open it:

```bash
heroku open
```
