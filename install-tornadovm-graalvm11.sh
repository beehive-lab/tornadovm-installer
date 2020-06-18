#!/usr/bin/env bash

mkdir -p TornadoVM-Graal11

cd TornadoVM-Graal11
platform=`uname |tr '[:upper:]' '[:lower:]'`

# 1) Download GraalVM Java 11
if [[ "$platform" == 'linux' ]]; then
	wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-19.3.0/graalvm-ce-java11-linux-amd64-19.3.0.tar.gz
	tar -xf graalvm-ce-java11-linux-amd64-19.3.0.tar.gz
elif [[ "$platform" == 'darwing' ]]; then
	wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-19.3.0/graalvm-ce-java11-darwin-amd64-19.3.0.tar.gz
	tar -xf graalvm-ce-java11-darwin-amd64-19.3.0.tar.gz
fi
JDK_BASE=`pwd`
export JAVA_HOME=$PWD/graalvm-ce-java11-19.3.0

# 2) Download CMAKE
if [[ "$platform" == 'linux' ]]; then
	wget https://github.com/Kitware/CMake/releases/download/v3.18.0-rc2/cmake-3.18.0-rc2-Linux-x86_64.tar.gz
	tar xzf cmake-3.18.0-rc2-Linux-x86_64.tar.gz
	export PATH=`pwd`/cmake-3.18.0-rc2-Linux-x86_64/bin:$PATH
	export CMAKE_ROOT=`pwd`/cmake-3.18.0-rc2-Linux-x86_64/
elif [[ "$platform" == 'linux' ]]; then
	wget https://github.com/Kitware/CMake/releases/download/v3.18.0-rc2/cmake-3.18.0-rc2-Darwin-x86_64.tar.gz
	tar xfz cmake-3.18.0-rc2-Darwin-x86_64.tar.gz
	export PATH=`pwd`/cmake-3.18.0-rc2-Darwin-x86_64/CMake.app/Contents/bin:$PATH
	export CMAKE_ROOT=`pwd`/cmake-3.18.0-rc2-Darwin-x86_64/CMake.app/Contents
fi

# 3) Download TornadoVM
git clone --depth 1 https://github.com/beehive-lab/TornadoVM
cd TornadoVM
export PATH=$PWD/bin/bin:$PATH
export TORNADO_SDK=$PWD/bin/sdk
make graal-jdk-11

echo -e "To use TornadoVM, export the following variables:\n"

	echo "export JAVA_HOME=$JAVA_HOME" > source11.sh
	echo "export PATH=$PWD/bin/bin:\$PATH" >> source11.sh
	echo "export TORNADO_SDK=$PWD/bin/sdk" >> source11.sh
	echo "export CMAKE_ROOT=$CMAKE_ROOT" >> source11.sh
	echo "export TORNADO_ROOT=$PWD" >> source11.sh 


echo "To run TornadoVM, run \`. TornadoVM-Graal11/TornadoVM/source11.sh\`"

