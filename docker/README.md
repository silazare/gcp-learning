## Docker monolith

### Docker Machine usage via GCE

- Clone this repository and go to docker monolith folder:
```sh
$ git clone https://github.com/silazare/gcp-learning.git
$ cd gcp-learning/docker/monolith
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

- Remove docker-machine:
```sh
docker-machine rm docker-host -f
```

## Docker microservices

### General steps

- Clone this repository and go to docker microservices folder:
```sh
$ git clone https://github.com/silazare/gcp-learning.git
$ cd gcp-learning/docker/microservices
```

- Download latest mongo image:
```sh
docker pull mongo:latest
```

- Create our app images:
```sh
docker build -t <your-login>/post:1.0 ./post-py
docker build -t <your-login>/comment:2.0 ./comment
docker build -t <your-login>/ui:2.0 ./ui
```
- Create docker bridge network:
```sh
docker network create reddit --driver bridge
```

- Create docker volume:
```sh
docker volume create reddit_db
```

- Run containers:
```sh
docker run -d --network=reddit -v reddit_db:/data/db \
--network-alias=post_db --network-alias=comment_db mongo:latest

docker run -d --network=reddit \
--network-alias=post <your-login>/post:1.0

docker run -d --network=reddit \
--network-alias=comment <your-login>/comment:2.0

docker run -d --network=reddit \
-p 9292:9292 <your-login>/ui:2.0
```

- Kill containers:
```sh
docker kill $(docker ps -q)
```

### Docker Networking

- Create symlink for net namespace:
```sh
sudo ln -s /var/run/docker/netns /var/run/netns
```

- Research different network types and interfaces with net-tools image and compare ifconfig outputs:
```sh
docker run --network none --rm -d --name net_test joffotron/docker-net-tools -c "sleep 100"

docker run --network host --rm -d --name net_test joffotron/docker-net-tools -c "sleep 100"

docker exec -ti net_test ifconfig

sudo ip netns
```

- Run Reddit in 2 bridge networks:
```sh
docker network create back_net --subnet=10.0.2.0/24
docker network create front_net --subnet=10.0.1.0/24

docker run -d --network=front_net -p 9292:9292 --name ui  <your-login>/ui:2.0
docker run -d --network=back_net --name comment  <your-login>/comment:2.0
docker run -d --network=back_net --name post  <your-login>/post:1.0
docker run -d --network=back_net --name mongo_db --network-alias=post_db --network-alias=comment_db mongo:latest
```
- Attach containers to front_net network to make service OK:
```sh
docker network connect front_net post
docker network connect front_net comment
```

### Docker Compose

- Start docker compose with default variables from .env:

```sh
docker-compose up -d
docker-compose ps
```

### Appendix A: Additional commands

- Test container with more user privileges:
```sh
docker run --rm --pid host -ti tehbilly/htop
```

- Show docker container env:
```sh
docker exec <id> env
```
