BRANCH=$(git branch --show-current)

IMAGE=yoedistro/yoe-build:$BRANCH

yoe_docker_build() {
  DOCKER_BUILDKIT=1 docker build -t "$IMAGE" --platform linux/`uname -m` .
}

yoe_docker_upload() {
  docker push "$IMAGE"
}
