## TornadoVM Installer

Script to install [TornadoVM](https://github.com/beehive-lab/TornadoVM/)

**Pre-requisites**

* Maven Version 3.6.3
* OpenCL: GPUs and CPUs >= 1.2, FPGAs >= 1.0
* GCC or clang/LLVM (GCC >= 5.5)
* Python 2.7 (>= 2.7.5)

### How to install TornadoVM? 

The scripts provided in this repository will compile/download OpenJDK, `cmake` and it will build TornadoVM.

This installation script has been tested on Linux and OSx.
Note that GraalVM Community Edition releases based on JDK8 are no longer being built for Mac OSx.

```bash
TornadoVM installer for Linux and OSx
Usage:
       --jdk8           : Install TornadoVM with OpenJDK 8  (Default)
       --graal-jdk-8    : Install TornadoVM with GraalVM and JDK 8 (GraalVM 21.1.0)
       --graal-jdk-11   : Install TornadoVM with GraalVM and JDK 11 (GraalVM 21.1.0)
       --graal-jdk-16   : Install TornadoVM with GraalVM and JDK 16 (GraalVM 21.1.0)
       --corretto-11    : Install TornadoVM with Corretto JDK 11
       --corretto-16    : Install TornadoVM with Corretto JDK 16
       --mandrel-11     : Install TornadoVM with Mandrel 21.1.0 (JDK 11)
       --windows-jdk-11 : Install TornadoVM with Windows JDK 11
       --windows-jdk-16 : Install TornadoVM with Windows JDK 16
       --help           : Print this help

```

To use TornadoVM with OpenJDK 8:

```bash
./tornadovmInstaller.sh --jk8
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

After the installation, the scripts create a directory with the TornadoVM SDK. The directory also includes a source file with all variables needed to start using TornadoVM. 


Example:
```bash
$ source TornadoVM-RedHat-Mandrel11/TornadoVM/source.sh

$ tornado --version
version=0.9
branch=master
commit=fda5e2e

$ tornado -version
openjdk version "11.0.9" 2020-10-20
OpenJDK Runtime Environment 18.9 (build 11.0.9+11)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.9+11, mixed mode)

$ tornado --devices

Number of Tornado drivers: 1
Total number of OpenCL devices  : 4
Tornado device=0:0
	NVIDIA CUDA -- GeForce GTX 1050
		Global Memory Size: 3.9 GB
		Local Memory Size: 48.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [1024, 1024, 64]
		Device OpenCL C version: OpenCL C 1.2

Tornado device=0:1
	AMD Accelerated Parallel Processing -- Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz
		Global Memory Size: 31.0 GB
		Local Memory Size: 32.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [1024, 1024, 1024]
		Device OpenCL C version: OpenCL C 1.2

Tornado device=0:2
	Intel(R) OpenCL HD Graphics -- Intel(R) HD Graphics 630 [0x591b]
		Global Memory Size: 24.8 GB
		Local Memory Size: 64.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [256, 256, 256]
		Device OpenCL C version: OpenCL C 3.0

Tornado device=0:3
	Intel(R) CPU Runtime for OpenCL(TM) Applications -- Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz
		Global Memory Size: 31.0 GB
		Local Memory Size: 32.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [8192, 8192, 8192]
		Device OpenCL C version: OpenCL C 2.0
```
