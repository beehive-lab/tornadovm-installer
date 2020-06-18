#!/usr/bin/env bash

currentver="$(gcc -dumpversion)"
requiredver="5.5.0"
if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then 
        echo "GCC Vesion: OK"
else
        echo "Less than 5.5.0"
		exit
fi


if [ -z "$JAVA_HOME" ];
then
	echo "JAVA_HOME is not set. Use OpenJDK 8 >= 141 <= 1.9"
	echo "\t You can use \`ls -l /etc/alternatives/java\` to get the PATHs"
 	exit 0
else
 	echo "JDK Version: OK"
fi

# 1) Download OpenJDK with JVMCI support
mkdir -p TornadoVM-JDK8

cd TornadoVM-JDK8
JDK_BASE=`pwd`
git clone --depth 1 https://github.com/beehive-lab/mx
export PATH=`pwd`/mx:$PATH
git clone --depth 1 https://github.com/beehive-lab/graal-jvmci-8
cd graal-jvmci-8
mx build -p
OPENJDK=`ls | grep jdk`
export JAVA_HOME=`pwd`/$OPENJDK/linux-amd64/product/
cd -

# 2) Download CMAKE
wget https://github.com/Kitware/CMake/releases/download/v3.18.0-rc2/cmake-3.18.0-rc2-Linux-x86_64.tar.gz
tar xzf cmake-3.18.0-rc2-Linux-x86_64.tar.gz
export PATH=`pwd`/cmake-3.18.0-rc2-Linux-x86_64/bin:$PATH
export CMAKE_ROOT=`pwd`/cmake-3.18.0-rc2-Linux-x86_64/

# 3) Download TornadoVM
git clone --depth 1 https://github.com/beehive-lab/TornadoVM
cd TornadoVM
export PATH=$PWD/bin/bin:$PATH
export TORNADO_SDK=$PWD/bin/sdk
make 

echo -e "To use TornadoVM, export the following variables:\n"

echo "Creating Source File ....... " 
	echo "export JAVA_HOME=$JAVA_HOME" > source.sh
	echo "export PATH=$PWD/bin/bin:\$PATH" >> source.sh
	echo "export TORNADO_SDK=$PWD/bin/sdk" >> source.sh
	echo "export CMAKE_ROOT=$PWD/cmake-3.18.0-rc2-Linux-x86_64/" >> source.sh
	echo "export TORNADO_ROOT=$PWD " >> source.sh
echo "........................... [OK]"


echo "To run TornadoVM, run \`. TornadoVM-JDK8/TornadoVM/source.sh\`"


