## TornadoVM Installer

Script to install [TornadoVM](https://github.com/beehive-lab/TornadoVM/).

**Pre-requisites**

* Maven Version 3.6.3
* OpenCL: GPUs and CPUs >= 1.2, FPGAs >= 1.0
* GCC or clang/LLVM (GCC >= 5.5)
* Python >= 3.6 

### How to install TornadoVM? 

The scripts provided in this repository will compile/download OpenJDK, `cmake` and it will build TornadoVM.

This installation script has been tested on Linux and OSx.
Note that GraalVM Community Edition releases based on JDK8 are no longer being built for Mac OSx.

```bash
TornadoVM installer for Linux and OSx
Usage:
       --jdk8           : Install TornadoVM with OpenJDK 8  (Default)
       --jdk11          : Install TornadoVM with OpenJDK 11
       --jdk16          : Install TornadoVM with OpenJDK 16
       --graal-jdk-8    : Install TornadoVM with GraalVM and JDK 8 (GraalVM 21.1.0)
       --graal-jdk-11   : Install TornadoVM with GraalVM and JDK 11 (GraalVM 21.1.0)
       --graal-jdk-16   : Install TornadoVM with GraalVM and JDK 16 (GraalVM 21.1.0)
       --corretto-11    : Install TornadoVM with Corretto JDK 11
       --corretto-16    : Install TornadoVM with Corretto JDK 16
       --mandrel-11     : Install TornadoVM with Mandrel 21.1.0 (JDK 11)
       --windows-jdk-11 : Install TornadoVM with Windows JDK 11
       --windows-jdk-16 : Install TornadoVM with Windows JDK 16
       --opencl         : Install TornadoVM and build the OpenCL backend
       --ptx            : Install TornadoVM and build the PTX backend
       --help           : Print this help

```

To use TornadoVM with OpenJDK 8:

```bash
./tornadovmInstaller.sh --jdk8
# and follow instructions
```

To build TornadoVM with GraalVM and JDK 8:


```bash
./tornadovmInstaller.sh --graal-jdk-8
# and follow instructions
```


To build TornadoVM with GraalVM and JDK 11:


```bash
./tornadovmInstaller.sh --graal-jdk-11
# and follow instructions
```

To build TornadoVM with Red Hat Mandrel JDK 11 with OpenCL and PTX backends:


```bash
./tornadovmInstaller.sh --mandrel-11 --opencl --ptx
# and follow instructions
```

After the installation, the scripts create a directory with the TornadoVM SDK. The directory also includes a source file with all variables needed to start using TornadoVM. 


For example:
```bash
$ source TornadoVM-RedHat-Mandrel11/TornadoVM/source.sh

$ tornado --version
version=0.11-dev
branch=master
commit=d68cc95

$ tornado -version
openjdk version "11.0.12" 2021-07-20
OpenJDK Runtime Environment 18.9 (build 11.0.12+7)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.12+7, mixed mode)

$ tornado --devices

Number of Tornado drivers: 2
Total number of PTX devices  : 1
Tornado device=0:0
	PTX -- GeForce GTX 1050 Ti with Max-Q Design
		Global Memory Size: 3.9 GB
		Local Memory Size: 48.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [1024, 1024, 64]
		Device OpenCL C version: N/A

Total number of OpenCL devices  : 3
Tornado device=1:0
	NVIDIA CUDA -- GeForce GTX 1050 Ti with Max-Q Design
		Global Memory Size: 3.9 GB
		Local Memory Size: 48.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [1024, 1024, 64]
		Device OpenCL C version: OpenCL C 1.2

Tornado device=1:1
	Experimental OpenCL 2.1 CPU Only Platform -- Intel(R) Core(TM) i9-8950HK CPU @ 2.90GHz
		Global Memory Size: 31.1 GB
		Local Memory Size: 32.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [8192, 8192, 8192]
		Device OpenCL C version: OpenCL C 2.0

Tornado device=1:2
	Intel(R) OpenCL HD Graphics -- Intel(R) Graphics Gen9 [0x3e9b]
		Global Memory Size: 24.8 GB
		Local Memory Size: 64.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [256, 256, 256]
		Device OpenCL C version: OpenCL C 3.0
```
