#!/usr/bin/env bash

#  Copyright (c) 2020, APT Group, Department of Computer Science,
#  The University of Manchester.
# 
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# 

function getPlatform() {
    platform=$(uname | tr '[:upper:]' '[:lower:]')
    echo "$platform"
}

function checkJavaVersion() {
    platform=$(getPlatform)
    pass=$1
    if [ -z "$JAVA_HOME" ];
    then
	    echo "JAVA_HOME is not set. Use OpenJDK 8 >= 141 <= 1.9"
    	if [[ "$platform" == 'linux' ]]; then
	    	# shellcheck disable=SC2028
	    	echo "\t You can use \`ls -l /etc/alternatives/java\` to get the PATHs"
	    elif [[ "$platform" == 'darwin' ]]; then
		    echo "\t You can use export JAVA_HOME=\$(/usr/libexec/java_home)"
	    fi
 	    pass=0
    else
 	    echo "JDK Version: OK"
    fi
    return $pass
}

function checkPrerequisites() {
    currentver="$(gcc -dumpversion)"
    requiredver="5.5.0"
    pass=1
    # if [ "$(printf '%s\n' "$requiredver" "$currentver" | sort -V | head -n1)" = "$requiredver" ]; then 
    #     echo "GCC Vesion: OK"
    # else
    #     echo "Error: GCC Version is less than 5.5.0"
    #     pass=0
    # fi

    #$pass=checkJavaVersion($pass)

    if [[ $pass == 0 ]]; then
        exit
    fi
}

# Download OpenJDK with JVMCI support
function downloadOpenJDK8() {
    export JDK_BASE=$(pwd)
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        echo "Downloading JDK8 with JVMCI... ~100MB"
        wget https://github.com/graalvm/graal-jvmci-8/releases/download/jvmci-20.2-b03/openjdk-8u262+10-jvmci-20.2-b03-linux-amd64.tar.gz
        tar xvzf openjdk-8u262+10-jvmci-20.2-b03-linux-amd64.tar.gz
        export JAVA_HOME=$JDK_BASE/openjdk1.8.0_262-jvmci-20.2-b03
    elif [[ "$platform" == 'darwin' ]]; then
        echo "Downloading JDK8 with JVMCI... ~100MB"
        wget https://github.com/graalvm/graal-jvmci-8/releases/download/jvmci-20.2-b03/openjdk-8u262+10-jvmci-20.2-b03-darwin-amd64.tar.gz
        tar xvzf openjdk-8u262+10-jvmci-20.2-b03-darwin-amd64.tar.gz
        export JAVA_HOME=$JDK_BASE/openjdk1.8.0_262-jvmci-20.2-b03/Contents/Home/
    else
        echo "OS platform not supported"
        exit 0
    fi
}

function downloadGraalVMJDK8() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then	
    	wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.2.0/graalvm-ce-java8-linux-amd64-20.2.0.tar.gz
	    tar -xf graalvm-ce-java8-linux-amd64-20.2.0.tar.gz
	    export JAVA_HOME=$PWD/graalvm-ce-java8-20.2.0
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.2.0/graalvm-ce-java8-darwin-amd64-20.2.0.tar.gz
	    tar -xf graalvm-ce-java8-darwin-amd64-20.2.0.tar.gz
	    export JAVA_HOME=$PWD/graalvm-ce-java8-20.2.0/Contents/Home/
    fi
}

function downloadGraalVMJDK11() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.2.0/graalvm-ce-java11-linux-amd64-20.2.0.tar.gz
	    tar -xf graalvm-ce-java11-linux-amd64-20.2.0.tar.gz
	    export JAVA_HOME=$PWD/graalvm-ce-java11-20.2.0
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-20.2.0/graalvm-ce-java11-darwin-amd64-20.2.0.tar.gz
	    tar -xf graalvm-ce-java11-darwin-amd64-20.2.0.tar.gz
	    export JAVA_HOME=$PWD/graalvm-ce-java11-20.2.0/Contents/Home/
    fi
}

function downloadCorretto11() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz
        tar xf amazon-corretto-11-x64-linux-jdk.tar.gz
        export JAVA_HOME=$PWD/amazon-corretto-11.0.9.12.1-linux-x64
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://corretto.aws/downloads/latest/amazon-corretto-11-x64-macos-jdk.tar.gz
        tar xf amazon-corretto-11-x64-macos-jdk.tar.gz
        export JAVA_HOME=$PWD/amazon-corretto-11.jdk/Contents/Home
    fi
}

function downloadCMake01() {
    platform=$1
    if [[ "$platform" == 'linux' ]]; then
	    wget https://github.com/Kitware/CMake/releases/download/v3.18.0-rc2/cmake-3.18.0-rc2-Linux-x86_64.tar.gz
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://github.com/Kitware/CMake/releases/download/v3.18.0-rc2/cmake-3.18.0-rc2-Darwin-x86_64.tar.gz
    else 
        echo "OS platform not supported"
        exit 0
    fi
}

function unZipAndSetCmake() {
    platform=$1
    if [[ "$platform" == 'linux' ]]; then
        tar xzf cmake-3.18.0-rc2-Linux-x86_64.tar.gz
        export PATH=`pwd`/cmake-3.18.0-rc2-Linux-x86_64/bin:$PATH
        export CMAKE_ROOT=`pwd`/cmake-3.18.0-rc2-Linux-x86_64/
    elif [[ "$platform" == 'darwin' ]]; then
        tar xfz cmake-3.18.0-rc2-Darwin-x86_64.tar.gz
        export PATH=`pwd`/cmake-3.18.0-rc2-Darwin-x86_64/CMake.app/Contents/bin:$PATH
        export CMAKE_ROOT=`pwd`/cmake-3.18.0-rc2-Darwin-x86_64/CMake.app/Contents
    else 
        echo "OS platform not supported"
        exit 0
    fi
}

# Download CMAKE
function downloadCMake() {
    platform=$(getPlatform)
    FILE="cmake-3.18.0-rc2-Linux-x86_64.tar.gz"
    if [ ! -f "$FILE" ]; then
        downloadCMake01 $platform
        unZipAndSetCmake $platform
    else
        unZipAndSetCmake $platform
    fi
}

# Download and Install TornadoVM 
function setupTornadoVM() {
    if [ ! -d TornadoVM ]; then 
        git clone --depth 1 https://github.com/beehive-lab/TornadoVM
    else 
        cd TornadoVM
        git pull 
        cd -
    fi
    cd TornadoVM
    export PATH=$PWD/bin/bin:$PATH
    export TORNADO_SDK=$PWD/bin/sdk
    make $1
}

function setupVariables() {
    DIR=$1
    echo -e "To use TornadoVM, export the following variables:\n"
    echo "Creating Source File ....... " 
	  echo "export JAVA_HOME=$JAVA_HOME" > source.sh
	  echo "export PATH=$PWD/bin/bin:\$PATH" >> source.sh
	  echo "export TORNADO_SDK=$PWD/bin/sdk" >> source.sh
	  echo "export CMAKE_ROOT=$CMAKE_ROOT" >> source.sh
	  echo "export TORNADO_ROOT=$PWD " >> source.sh
    echo "........................... [OK]"

    echo "To run TornadoVM, run \`. $DIR/TornadoVM/source.sh\`"
}

function installForJDK8() {
    checkPrerequisites
    dirname="TornadoVM-JDK8"
    mkdir -p $dirname
    cd $dirname
    downloadOpenJDK8 
    downloadCMake
    setupTornadoVM 
    setupVariables $dirname
}

function installForGraalJDK8() {
    checkPrerequisites
    dirname="TornadoVM-GraalJDK8"
    mkdir -p $dirname
    cd $dirname
    downloadGraalVMJDK8
    downloadCMake
    setupTornadoVM graal-jdk-8
    setupVariables $dirname
}

function installForGraalJDK11() {
    checkPrerequisites
    dirname="TornadoVM-GraalJDK11"
    mkdir -p $dirname
    cd $dirname
    downloadGraalVMJDK11
    downloadCMake
    setupTornadoVM graal-jdk-11
    setupVariables $dirname
}

function installForCorrettoJDK11() {
    checkPrerequisites
    dirname="TornadoVM-Amazon-Corretto11"
    mkdir -p $dirname
    cd $dirname
    downloadCorretto11
    downloadCMake
    setupTornadoVM jdk-11-plus
    setupVariables $dirname
}

function printHelp() {
    echo "TornadoVM installer"
    echo "Usage:"
    echo "       --jdk8         : Install TornadoVM with OpenJDK 8  (Default)"
    echo "       --graal-jdk-8  : Install TornadoVM with GraalVM and JDK 8"
    echo "       --graal-jdk-11 : Install TornadoVM with GraalVM and JDK 11"
    echo "       --corretto-11  : Install TornadoVM with Corretto JDK 11"
    echo "       --help         : Print this help"
    exit 0
}

POSITIONAL=()

if [[ $# == 0 ]] 
then
    printHelp
    exit
fi

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
  --help)
    printHelp
    shift
    ;;
  --jdk8)
    installForJDK8
    shift
    ;;
  --graal-jdk-8)
    installForGraalJDK8
    shift 
    ;;
  --graal-jdk-11)
    installForGraalJDK11
    shift 
    ;;
  --corretto-11)
    installForCorrettoJDK11
    shift 
    ;;
  *)
    printHelp
    shift 
    ;;
  esac
done
