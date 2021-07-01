VERSION=0.0.1
GO111MODULE=off
# Image URL to use all building/pushing image targets
IMG=zhangqiongjie/web-terminal:${VERSION}


# build the docker image
docker-build:
	docker build . -t ${IMG}

# push the docker image
docker-push:
	docker push ${IMG}
