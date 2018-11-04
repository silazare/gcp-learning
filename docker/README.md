## Docker simple project

### Docker Machine simple usage via GCE:

gcloud init
gcloud auth application-default login

docker-machine create --driver google \
--google-project docker-test-221517 \
--google-zone europe-west1-b \
--google-machine-type f1-micro \
--google-machine-image $(gcloud compute images list --filter ubuntu-1604-lts --uri) \
docker-host

docker-machine ls
docker-machine ip docker-host
eval $(docker-machine env docker-host)
docker-machine ssh docker-host

docker run --rm --pid host -ti tehbilly/htop -- Test container with more user privileges
