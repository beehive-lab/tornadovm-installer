#!/usr/bin/env bash

#  Copyright (c) 2020-2021, APT Group, Department of Computer Science,
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
        wget https://github.com/graalvm/graal-jvmci-8/releases/download/jvmci-21.2-b08/openjdk-8u302+07-jvmci-21.2-b08-linux-amd64.tar.gz 
	tar xvzf openjdk-8u302+07-jvmci-21.2-b08-linux-amd64.tar.gz
        export JAVA_HOME=$JDK_BASE/openjdk1.8.0_302-jvmci-21.2-b08
    elif [[ "$platform" == 'darwin' ]]; then
        echo "JDK8 with JVMCI for Mac OSx is not supported for Graal 21.2"
        cd ../ && rm -rf $dirname
	exit 0
    else
        echo "OS platform not supported"
        cd ../ & rm -rf $dirname
        exit 0
    fi
}

function downloadOpenJDK11() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.12%2B7/OpenJDK11U-jdk_x64_linux_hotspot_11.0.12_7.tar.gz
        tar -xf OpenJDK11U-jdk_x64_linux_hotspot_11.0.12_7.tar.gz
        export JAVA_HOME=$PWD/jdk-11.0.12+7
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://github.com/adoptium/temurin11-binaries/releases/download/jdk-11.0.12%2B7/OpenJDK11U-jdk_x64_mac_hotspot_11.0.12_7.tar.gz
        tar -xf OpenJDK11U-jdk_x64_mac_hotspot_11.0.12_7.tar.gz
        export JAVA_HOME=$PWD/jdk-11.0.12+7/Contents/Home/
    fi
}

function downloadOpenJDK16() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://github.com/adoptium/temurin16-binaries/releases/download/jdk-16.0.2%2B7/OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz
        tar -xf OpenJDK16U-jdk_x64_linux_hotspot_16.0.2_7.tar.gz
        export JAVA_HOME=$PWD/jdk-16.0.2+7
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://github.com/adoptium/temurin16-binaries/releases/download/jdk-16.0.2%2B7/OpenJDK16U-jdk_x64_mac_hotspot_16.0.2_7.tar.gz
        tar -xf OpenJDK16U-jdk_x64_mac_hotspot_16.0.2_7.tar.gz
        export JAVA_HOME=$PWD/jdk-16.0.2+7/Contents/Home/
    fi
}

function downloadGraalVMJDK8() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then	
        wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.2.0/graalvm-ce-java8-linux-amd64-21.2.0.tar.gz
	tar -xf graalvm-ce-java8-linux-amd64-21.2.0.tar.gz
	export JAVA_HOME=$PWD/graalvm-ce-java8-21.2.0
    elif [[ "$platform" == 'darwin' ]]; then
        echo "JDK8 for Mac OSx is not supported for Graal 21.2"
        cd ../ && rm -rf $dirname
	exit 0
    fi
}

function downloadGraalVMJDK11() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.2.0/graalvm-ce-java11-linux-amd64-21.2.0.tar.gz
	tar -xf graalvm-ce-java11-linux-amd64-21.2.0.tar.gz
	export JAVA_HOME=$PWD/graalvm-ce-java11-21.2.0
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.2.0/graalvm-ce-java11-darwin-amd64-21.2.0.tar.gz
        tar -xf graalvm-ce-java11-darwin-amd64-21.2.0.tar.gz
        export JAVA_HOME=$PWD/graalvm-ce-java11-21.2.0/Contents/Home/
    fi
}

function downloadGraalVMJDK16() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.2.0/graalvm-ce-java16-linux-amd64-21.2.0.tar.gz
        tar -xf graalvm-ce-java16-linux-amd64-21.2.0.tar.gz
        export JAVA_HOME=$PWD/graalvm-ce-java16-21.2.0
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-21.2.0/graalvm-ce-java16-darwin-amd64-21.2.0.tar.gz
        tar -xf graalvm-ce-java16-darwin-amd64-21.2.0.tar.gz
        export JAVA_HOME=$PWD/graalvm-ce-java16-21.2.0/Contents/Home/
    fi
}

function downloadCorretto11() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://corretto.aws/downloads/latest/amazon-corretto-11-x64-linux-jdk.tar.gz
        tar xf amazon-corretto-11-x64-linux-jdk.tar.gz
        export JAVA_HOME=$PWD/amazon-corretto-11.0.12.7.1-linux-x64
    elif [[ "$platform" == 'darwin' ]]; then
	wget https://corretto.aws/downloads/latest/amazon-corretto-11-x64-macos-jdk.tar.gz        
        tar xf amazon-corretto-11-x64-macos-jdk.tar.gz
        export JAVA_HOME=$PWD/amazon-corretto-11.jdk/Contents/Home
    fi
}

function downloadCorretto16() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://corretto.aws/downloads/latest/amazon-corretto-16-x64-linux-jdk.tar.gz
        tar xf amazon-corretto-16-x64-linux-jdk.tar.gz
        export JAVA_HOME=$PWD/amazon-corretto-16.0.2.7.1-linux-x64
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://corretto.aws/downloads/latest/amazon-corretto-16-x64-macos-jdk.tar.gz
        tar xf amazon-corretto-16-x64-macos-jdk.tar.gz
        export JAVA_HOME=$PWD/amazon-corretto-16.jdk/Contents/Home
    fi
}

function downloadMandrel11() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://github.com/graalvm/mandrel/releases/download/mandrel-21.2.0.0-Final/mandrel-java11-linux-amd64-21.2.0.0-Final.tar.gz
        tar xf mandrel-java11-linux-amd64-21.2.0.0-Final.tar.gz
        export JAVA_HOME=$PWD/mandrel-java11-21.2.0.0-Final
    elif [[ "$platform" == 'darwin' ]]; then
        echo "OS Not supported"
        cd ../ && rm -rf $dirname
        exit 0
    fi
}

function downloadWindowsJDK11() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://aka.ms/download-jdk/microsoft-jdk-11.0.12.7.1-linux-x64.tar.gz 
        tar xf microsoft-jdk-11.0.12.7.1-linux-x64.tar.gz
        export JAVA_HOME=$PWD/jdk-11.0.12+7
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://aka.ms/download-jdk/microsoft-jdk-11.0.12.7.1-macOS-x64.tar.gz
        tar xf microsoft-jdk-11.0.12.7.1-macos-x64.tar.gz        
        export JAVA_HOME=$PWD/jdk-11.0.12+7/Contents/Home
    fi
}

function downloadWindowsJDK16() {
    platform=$(getPlatform)
    if [[ "$platform" == 'linux' ]]; then
        wget https://aka.ms/download-jdk/microsoft-jdk-16.0.2.7.1-linux-x64.tar.gz
        tar xf microsoft-jdk-16.0.2.7.1-linux-x64.tar.gz
        export JAVA_HOME=$PWD/jdk-16.0.2+7
    elif [[ "$platform" == 'darwin' ]]; then
        wget https://aka.ms/download-jdk/microsoft-jdk-16.0.2.7.1-macos-x64.tar.gz
        tar xf microsoft-jdk-16.0.2.7.1-macos-x64.tar.gz
        export JAVA_HOME=$PWD/jdk-16.0.2+7/Contents/Home
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
    resolveBackends
    make $1 $backend
}

function resolveBackends() {
    if [[ "$opencl" && "$ptx" && "$spirv" ]] ; then
        backend="BACKENDS=opencl,ptx,spirv"    
    elif [[ "$opencl" && "$ptx" ]] ; then
	backend="BACKENDS=opencl,ptx"
    elif [[ "$opencl" && "$spirv" ]] ; then
        backend="BACKENDS=opencl,spirv"
    elif [[ "$spirv" && "$ptx" ]] ; then
        backend="BACKENDS=ptx,spirv"
    elif [ "$ptx" ] ; then
        backend="BACKEND=ptx"
    elif [ "$spirv" ] ; then
        backend="BACKEND=spirv"
    fi 

    if [[ "$backend" == '' ]]; then
	backend="BACKEND=opencl"
    fi
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

function installForOpenJDK8() {
    checkPrerequisites
    dirname="TornadoVM-OpenJDK8"
    mkdir -p $dirname
    cd $dirname
    downloadOpenJDK8 
    downloadCMake
    setupTornadoVM 
    setupVariables $dirname
}

function installForOpenJDK11() {
    checkPrerequisites
    dirname="TornadoVM-OpenJDK11"
    mkdir -p $dirname
    cd $dirname
    downloadOpenJDK11
    downloadCMake
    setupTornadoVM jdk-11-plus
    setupVariables $dirname
}

function installForOpenJDK16() {
    checkPrerequisites
    dirname="TornadoVM-OpenJDK16"
    mkdir -p $dirname
    cd $dirname
    downloadOpenJDK16
    downloadCMake
    setupTornadoVM jdk-11-plus
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
    setupTornadoVM graal-jdk-11-plus
    setupVariables $dirname
}

function installForGraalJDK16() {
    checkPrerequisites
    dirname="TornadoVM-GraalJDK16"
    mkdir -p $dirname
    cd $dirname
    downloadGraalVMJDK16
    downloadCMake
    setupTornadoVM graal-jdk-11-plus
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

function installForCorrettoJDK16() {
    checkPrerequisites
    dirname="TornadoVM-Amazon-Corretto16"
    mkdir -p $dirname
    cd $dirname
    downloadCorretto16
    downloadCMake
    setupTornadoVM jdk-11-plus
    setupVariables $dirname
}

function installForMandrelJDK11() {
    checkPrerequisites
    dirname="TornadoVM-RedHat-Mandrel11"
    mkdir -p $dirname
    cd $dirname
    downloadMandrel11
    downloadCMake
    setupTornadoVM jdk-11-plus
    setupVariables $dirname
}

function installForWindowsJDK11() {
    checkPrerequisites
    dirname="TornadoVM-Windows-JDK11"
    mkdir -p $dirname
    cd $dirname
    downloadWindowsJDK11
    downloadCMake
    setupTornadoVM jdk-11-plus
    setupVariables $dirname
}

function installForWindowsJDK16() {
    checkPrerequisites
    dirname="TornadoVM-Windows-JDK16"
    mkdir -p $dirname
    cd $dirname
    downloadWindowsJDK16
    downloadCMake
    setupTornadoVM jdk-11-plus
    setupVariables $dirname
}

function printHelp() {
    echo "TornadoVM installer for Linux and OSx"
    echo "Usage:"
    echo "       --jdk8           : Install TornadoVM with OpenJDK 8  (Default)"
    echo "       --jdk11          : Install TornadoVM with OpenJDK 11"
    echo "       --jdk16          : Install TornadoVM with OpenJDK 16"
    echo "       --graal-jdk-8    : Install TornadoVM with GraalVM and JDK 8 (GraalVM 21.2.0)"
    echo "       --graal-jdk-11   : Install TornadoVM with GraalVM and JDK 11 (GraalVM 21.2.0)"
    echo "       --graal-jdk-16   : Install TornadoVM with GraalVM and JDK 16 (GraalVM 21.2.0)"
    echo "       --corretto-11    : Install TornadoVM with Corretto JDK 11"
    echo "       --corretto-16    : Install TornadoVM with Corretto JDK 16"
    echo "       --mandrel-11     : Install TornadoVM with Mandrel 21.2.0 (JDK 11)"
    echo "       --windows-jdk-11 : Install TornadoVM with Windows JDK 11"
    echo "       --windows-jdk-16 : Install TornadoVM with Windows JDK 16"
    echo "       --opencl         : Install TornadoVM and build the OpenCL backend"
    echo "       --ptx            : Install TornadoVM and build the PTX backend"
    echo "       --spirv          : Install TornadoVM and build the SPIR-V backend"
    echo "       --help           : Print this help"
    exit 0
}

function setBackend() {
for i in ${args[@]}
do
  flag=$i
  if [[ "$flag" == '--opencl' ]]; then
    opencl=true
  elif [[ "$flag" == '--ptx' ]]; then
    ptx=true
  elif [[ "$flag" == '--spirv' ]]; then
    spirv=true
  fi
done
}

POSITIONAL=()

if [[ $# == 0 ]] 
then
    printHelp
    exit
fi

args=( "$@" )

setBackend

for i in ${args[@]} 
do
  key=$i
  case $key in
  --help)
    printHelp
    shift
    ;;
  --jdk8)
    installForOpenJDK8
    shift
    ;;
  --jdk11)
    installForOpenJDK11
    shift
    ;;
  --jdk16)
    installForOpenJDK16
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
  --graal-jdk-16)
    installForGraalJDK16
    shift
    ;;
  --corretto-11)
    installForCorrettoJDK11
    shift 
    ;;
  --corretto-16)
    installForCorrettoJDK16
    shift
    ;;
  --mandrel-11)
    installForMandrelJDK11
    shift
    ;;
  --windows-jdk-11)
    installForWindowsJDK11
    shift
    ;;
  --windows-jdk-16)
    installForWindowsJDK16
    shift
    ;;
  --opencl)
    shift
    ;;
  --ptx)
    shift
    ;;
  --spirv)
    shift
    ;;
  *)
    printHelp
    shift 
    ;;
  esac
done
