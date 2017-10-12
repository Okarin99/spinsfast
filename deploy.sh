#! /bin/bash

export datetime=$(date +"%Y.%m.%d.%H.%M.%S")
export package_version="104.${datetime}"

# Create a pure source pip package
python setup.py sdist upload

# Create all the osx binary pip packages
./python/build_macosx_wheels.sh

# Create all the osx conda packages
conda build .

# Start docker for the linux packages
open --hide --background -a Docker
while ! (docker ps > /dev/null 2>&1); do
    echo "Waiting for docker to start..."
    sleep 1
done

# Create all the linux binary pip packages on centos 5
docker run -i -t \
    -v ${HOME}/.pypirc:/root/.pypirc:ro \
    -v `pwd`:/code \
    -v `pwd`/python/build_manylinux_wheels.sh:/build_manylinux_wheels.sh \
    quay.io/pypa/manylinux1_x86_64 /build_manylinux_wheels.sh "${datetime}"

# Create all the linux binary conda packages on centos 6
docker build -t manyconda --pull python/docker_miniconda
docker run -i -t \
    -e package_version \
    -v ${HOME}/.condarc:/root/.condarc:ro \
    -v `pwd`:/code \
    manyconda bash -c 'conda build /code'
