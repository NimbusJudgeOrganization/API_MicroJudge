# Nimbus Judge Development HTTP API

## Run API container

```bash
$ docker build .
$ docker run -it -p 5000:5000 ec2-api
```

## Inside container

```bash
$ chmod +x judge/Judge/calibreitor.sh
$ chmod +x judge/Judge/build-and-test.sh
```

```bash
$ flask --app main run --host=0.0.0.0
```

## Running server

Server is running in localhost:5000
