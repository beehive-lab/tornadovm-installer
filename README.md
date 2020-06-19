## TornadoVM Installer

Scripts to install [TornadoVM](https://github.com/beehive-lab/TornadoVM/)

​
**Pre-requisites**

* Maven Version 3.6.3
* OpenCL: GPUs and CPUs >= 1.2, FPGAs >= 1.0
* GCC or clang/LLVM (GCC >= 5.5)
* Python 2.7 (>= 2.7.5)
* JDK 8 >= 1.8.0_141


### How to use? 

The scripts provided in this repository will compile/download OpenJDK, `cmake` and it will build TornadoVM.

This installation script has been tested on Linux and OSx. 

```bash
$ ./tornadovmInstaller.sh --help
TornadoVM installer
Usage:
       --jdk8         : Install TornadoVM with OpenJDK 8  (Default)
       --graal-jdk-8  : Install TornadoVM with GraalVM and JDK 8
       --graal-jdk-11 : Install TornadoVM with GraalVM and JDK 11
       --help         : Print this help
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
$ source TornadoVM-JDK8/TornadoVM/source.sh
$ tornado --version
version=0.6
branch=master
commit=4695f5c

$ tornado --devices

Number of Tornado drivers: 1
Total number of devices  : 3
Tornado device=0:0
	NVIDIA CUDA -- GeForce GTX 1050
		Global Memory Size: 3.9 GB
		Local Memory Size: 48.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [1024, 1024, 64]
		Device OpenCL C version: OpenCL C 1.2

Tornado device=0:1
	Intel(R) OpenCL -- Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz
		Global Memory Size: 31.0 GB
		Local Memory Size: 32.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [8192, 8192, 8192]
		Device OpenCL C version: OpenCL C 1.2

Tornado device=0:2
	Intel(R) OpenCL HD Graphics -- Intel(R) Gen9 HD Graphics NEO
		Global Memory Size: 24.8 GB
		Local Memory Size: 64.0 KB
		Workgroup Dimensions: 3
		Max WorkGroup Configuration: [256, 256, 256]
		Device OpenCL C version: OpenCL C 2.0
```
