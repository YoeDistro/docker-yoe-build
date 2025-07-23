BRANCH=$(git branch --show-current)

IMAGE=yoedistro/yoe-build:$BRANCH

yoe_docker_build() {
  docker buildx build -t "$IMAGE" --platform linux/`uname -m` .
}

yoe_docker_upload() {
  docker push "$IMAGE"
}
