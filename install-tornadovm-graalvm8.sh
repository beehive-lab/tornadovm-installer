#!/usr/bin/env bash

mkdir -p TornadoVM-Graal8

cd TornadoVM-Graal8

# 1) Download GraalVM Java 8
wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-19.3.0/graalvm-ce-java8-linux-amd64-19.3.0.tar.gz
tar -xf graalvm-ce-java8-linux-amd64-19.3.0.tar.gz
JDK_BASE=`pwd`
export JAVA_HOME=$PWD/graalvm-ce-java8-19.3.0

# 2) Download CMAKE
wget https://github.com/Kitware/CMake/releases/download/v3.18.0-rc2/cmake-3.18.0-rc2-Linux-x86_64.tar.gz
tar xvzf cmake-3.18.0-rc2-Linux-x86_64.tar.gz
export PATH=`pwd`/cmake-3.18.0-rc2-Linux-x86_64/bin:$PATH
export CMAKE_ROOT=`pwd`/cmake-3.18.0-rc2-Linux-x86_64/

# 3) Download & Build TornadoVM
git clone --depth 1 https://github.com/beehive-lab/TornadoVM
cd TornadoVM
export PATH=$PWD/bin/bin:$PATH
export TORNADO_SDK=$PWD/bin/sdk
make graal-jdk-8

echo -e "To use TornadoVM, export the following variables:\n"

	echo "export JAVA_HOME=$JAVA_HOME" > source8.sh
	echo "export PATH=$PWD/bin/bin:\$PATH" >> source8.sh
	echo "export TORNADO_SDK=$PWD/bin/sdk" >> source8.sh
	echo "export CMAKE_ROOT=$PWD/cmake-3.18.0-rc2-Linux-x86_64/" >> source8.sh
	echo "export TORNADO_ROOT=$PWD" >> source8.sh 


echo "To run TornadoVM, run \`. TornadoVM-Graal8/TornadoVM/source8.sh\`"

