
source /etc/profile
export |grep DOCKER_REG |grep -Ev "PASS|PW"
repo=registry.cn-shenzhen.aliyuncs.com
echo "${DOCKER_REGISTRY_PW_infrastSubUser2}" |docker login --username=${DOCKER_REGISTRY_USER_infrastSubUser2} --password-stdin $repo
repoHub=docker.io
echo "${DOCKER_REGISTRY_PW_dockerhub}" |docker login --username=${DOCKER_REGISTRY_USER_dockerhub} --password-stdin $repoHub


function doBuildx(){
    local tag=$1
    local dockerfile=$2

    repo=registry-1.docker.io
    # repo=registry.cn-shenzhen.aliyuncs.com
    test ! -z "$REPO" && repo=$REPO #@gitac
    img="build-nginx:$tag"
    # cache
    ali="registry.cn-shenzhen.aliyuncs.com"
    cimg="build-nginx-cache:$tag"
    cache="--cache-from type=registry,ref=$ali/$ns/$cimg --cache-to type=registry,ref=$ali/$ns/$cimg"
    
    plat="--platform linux/amd64,linux/arm64,linux/arm"
    # plat="--platform linux/amd64,linux/arm64" ##,linux/arm

    compile="alpine-compile";
    # test "$plat" != "--platform linux/amd64,linux/arm64,linux/arm" && compile="${compile}-dbg"
    # --build-arg REPO=$repo/ #temp notes, just use dockerHub's
    args="""
    --provenance=false 
    --build-arg REPO=$repo/
    --build-arg COMPILE_IMG=$compile
    --build-arg NOCACHE=$(date +%Y-%m-%d_%H:%M:%S)
    """

    # cd flux
    # test "$plat" != "--platform linux/amd64,linux/arm64,linux/arm" && img="${img}-dbg"
    # test "$plat" != "--platform linux/amd64,linux/arm64,linux/arm" && cimg="${cimg}-dbg"
    cache="--cache-from type=registry,ref=$ali/$ns/$cimg --cache-to type=registry,ref=$ali/$ns/$cimg"
    
    docker buildx build $cache $plat $args --push -t $repo/$ns/$img -f $dockerfile . 
}

ns=infrastlabs
ver=v51 #base-v5 base-v5-slim
case "$1" in
nginx)
    doBuildx latest Dockerfile
    ;;
*)
    # doBuildx $1 src/Dockerfile.$1
    echo "emp params"
    ;;          
esac