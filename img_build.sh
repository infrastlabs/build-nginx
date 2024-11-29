
cur=$(cd "$(dirname "$0")"; pwd)
cd $cur

#echo "export DOCKER_REGISTRY_USER_sdsir=xxx" >> /etc/profile
#echo "export DOCKER_REGISTRY_PW_sdsir=xxx" >> /etc/profile

source /etc/profile
export |grep DOCKER_REG
repo=registry.cn-shenzhen.aliyuncs.com
echo "${DOCKER_REGISTRY_PW_infrastSubUser2}" |docker login --username=${DOCKER_REGISTRY_USER_infrastSubUser2} --password-stdin $repo
test -z "$(uname -a |grep aarch64)" && arch=x64 || arch=arm64


# barge_docker_err: cgroups: cannot find cgroup mount destination: unknown.
# https://blog.csdn.net/HubertToLee/article/details/90373627
#  sudo mkdir /sys/fs/cgroup/systemd
#  sudo mount -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd

ns=infrastlabs
# cache="--no-cache"
# pull="--pull"
# ver=latest-echo #02: +full; 04: bins;
ver=v1.26.2-echo
img="build-nginx:$arch-$ver"

docker build $cache $pull -t $repo/$ns/$img -f Dockerfile . 
docker push $repo/$ns/$img
