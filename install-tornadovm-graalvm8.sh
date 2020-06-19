#!/usr/bin/env bash

mkdir -p TornadoVM-Graal8

cd TornadoVM-Graal8
platform=`uname |tr '[:upper:]' '[:lower:]'`

# 1) Download GraalVM Java 8
echo $platform
if [[ "$platform" == 'linux' ]]; then	
	wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-19.3.0/graalvm-ce-java8-linux-amd64-19.3.0.tar.gz
	tar -xf graalvm-ce-java8-linux-amd64-19.3.0.tar.gz
	JDK_BASE=`pwd`
	export JAVA_HOME=$PWD/graalvm-ce-java8-19.3.0
elif [[ "$platform" == 'darwin' ]]; then
	wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-19.3.0/graalvm-ce-java8-darwin-amd64-19.3.0.tar.gz
	tar -xf graalvm-ce-java8-darwin-amd64-19.3.0.tar.gz
	JDK_BASE=`pwd`
	export JAVA_HOME=$PWD/graalvm-ce-java8-19.3.0/Contents/Home/
fi

# 2) Download CMAKE
if [[ "$platform" == 'linux' ]]; then
	wget https://github.com/Kitware/CMake/releases/download/v3.18.0-rc2/cmake-3.18.0-rc2-Linux-x86_64.tar.gz
	tar xzf cmake-3.18.0-rc2-Linux-x86_64.tar.gz
	export PATH=`pwd`/cmake-3.18.0-rc2-Linux-x86_64/bin:$PATH
	export CMAKE_ROOT=`pwd`/cmake-3.18.0-rc2-Linux-x86_64/
elif [[ "$platform" == 'darwin' ]]; then
	wget https://github.com/Kitware/CMake/releases/download/v3.18.0-rc2/cmake-3.18.0-rc2-Darwin-x86_64.tar.gz
	tar xfz cmake-3.18.0-rc2-Darwin-x86_64.tar.gz
	export PATH=`pwd`/cmake-3.18.0-rc2-Darwin-x86_64/CMake.app/Contents/bin:$PATH
	export CMAKE_ROOT=`pwd`/cmake-3.18.0-rc2-Darwin-x86_64/CMake.app/Contents
fi

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
	echo "export CMAKE_ROOT=$CMAKE_ROOT" >> source8.sh
	echo "export TORNADO_ROOT=$PWD" >> source8.sh 


echo "To run TornadoVM, run \`. TornadoVM-Graal8/TornadoVM/source8.sh\`"

