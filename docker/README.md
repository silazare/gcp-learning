## Docker simple project

### Docker Machine usage via GCE:

- Clone this repository and go to docker folder:
```sh
$ git clone https://github.com/silazare/gcp-learning.git
$ cd gcp-learning/docker
```

- Init gcloud and auth for docker-machine:
```sh
gcloud init
gcloud auth application-default login

docker-machine create --driver google \
--google-project docker-test-221517 \
--google-zone europe-west1-b \
--google-machine-type g1-small \
--google-machine-image $(gcloud compute images list --filter ubuntu-1604-lts --uri) \
docker-host
```

- Check docker-machine status and eval variables:
```sh
docker-machine ls
eval $(docker-machine env docker-host)

docker-machine ssh docker-host
```

- Build docker image from Dockerfile:
```sh
docker build -t reddit:latest .
docker images -a
```

- Run docker container from image:
```sh
docker run --name reddit -d --network=host reddit:latest
```
- Check Reddit application:
```sh
docker-machine ip docker-host
http://<docker-machine-ip>:9292
```

- Login on Docker Hub:
```sh
docker login
```

- Tag and push Reddit image into Docker Hub:
```sh
docker tag reddit:latest <your-login>/test-reddit:1.0
docker push <your-login>/test-reddit:1.0
```


### Appendix A: Additional commands

- Test container with more user privileges:
```sh
docker run --rm --pid host -ti tehbilly/htop
```
