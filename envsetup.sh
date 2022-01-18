BRANCH=$(git branch --show-current)

IMAGE=yoedistro/yoe-build:$BRANCH

yoe_docker_build() {
  docker build -t "$IMAGE" .
}

yoe_docker_upload() {
  docker push "$IMAGE"
}
