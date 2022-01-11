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
./tornadovmInstaller.sh 
TornadoVM installer for Linux and OSx
Usage:
       --jdk8           : Install TornadoVM with OpenJDK 8
       --jdk11          : Install TornadoVM with OpenJDK 11
       --jdk17          : Install TornadoVM with OpenJDK 17
       --graal-jdk-11   : Install TornadoVM with GraalVM and JDK 11 (GraalVM 21.3.0)
       --graal-jdk-17   : Install TornadoVM with GraalVM and JDK 17 (GraalVM 21.3.0)
       --corretto-11    : Install TornadoVM with Corretto JDK 11
       --corretto-17    : Install TornadoVM with Corretto JDK 17
       --mandrel-11     : Install TornadoVM with Mandrel 21.3.0 (JDK 11)
       --mandrel-17     : Install TornadoVM with Mandrel 21.3.0 (JDK 17)
       --windows-jdk-11 : Install TornadoVM with Windows JDK 11
       --windows-jdk-17 : Install TornadoVM with Windows JDK 17
       --opencl         : Install TornadoVM and build the OpenCL backend
       --ptx            : Install TornadoVM and build the PTX backend
       --spirv          : Install TornadoVM and build the SPIR-V backend
       --help           : Print this help
```

To use TornadoVM with OpenJDK 8:

**NOTE** Select the desired backend:
  * `--opencl`: Enables the OpenCL backend (requires OpenCL drivers)
  * `--ptx`: Enables the PTX backend (requires NVIDIA CUDA drivers)
  * `--spirv`: Enables the SPIRV backend (requires Intel Level Zero drivers)


```bash
## Install with JDK8 with OpenCL 
./tornadovmInstaller.sh --jdk8 --opencl 
# and follow instructions
```

```bash
## Install with JDK8 with OpenCL & PTX
./tornadovmInstaller.sh --jdk8 --opencl --ptx
# and follow instructions
```

```bash
## Install with JDK8 with OpenCL & PTX & SPIRV
./tornadovmInstaller.sh --jdk8 --opencl --ptx --spirv
# and follow instructions
```


To build TornadoVM with GraalVM and JDK 11:

```bash
## I
./tornadovmInstaller.sh --graal-jdk-11 --opencl 
# and follow instructions
```


To build TornadoVM with GraalVM and JDK 17:


```bash
./tornadovmInstaller.sh --graal-jdk-17 --opencl
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
# Install with Graal JDK 17 and all backends
$ ./tornadovmInstaller.sh  --graal-jdk-17 --opencl --spirv --ptx
$ source TornadoVM-GraalJDK17/TornadoVM/source.sh

$ tornado --version
version=0.13-dev
branch=master
commit=256f715


$ tornado -version
openjdk version "11.0.12" 2021-07-20
OpenJDK Runtime Environment 18.9 (build 11.0.12+7)
OpenJDK 64-Bit Server VM 18.9 (build 11.0.12+7, mixed mode)

$ tornado -version
WARNING: Using incubator modules: jdk.incubator.foreign, jdk.incubator.vector
openjdk version "17.0.1" 2021-10-19
OpenJDK Runtime Environment GraalVM CE 21.3.0 (build 17.0.1+12-jvmci-21.3-b05)
OpenJDK 64-Bit Server VM GraalVM CE 21.3.0 (build 17.0.1+12-jvmci-21.3-b05, mixed mode)


$ tornado --devices


Number of Tornado drivers: 3
Driver: SPIRV
  Total number of SPIRV devices  : 1
  Tornado device=0:0
	SPIRV -- SPIRV LevelZero - Intel(R) UHD Graphics [0x9bc4]
		Global Memory Size: 24.9 GB
		Local Memory Size: 64.0 KB
		Workgroup Dimensions: 3
		Total Number of Block Threads: 256
		Max WorkGroup Configuration: [256, 256, 256]
		Device OpenCL C version:  (LEVEL ZERO) 1.1

Driver: OpenCL
  Total number of OpenCL devices  : 3
  Tornado device=1:0
	OPENCL --  [NVIDIA CUDA] -- NVIDIA GeForce RTX 2060 with Max-Q Design
		Global Memory Size: 5.8 GB
		Local Memory Size: 48.0 KB
		Workgroup Dimensions: 3
		Total Number of Block Threads: 1024
		Max WorkGroup Configuration: [1024, 1024, 64]
		Device OpenCL C version: OpenCL C 1.2

  Tornado device=1:1
	OPENCL --  [Intel(R) OpenCL HD Graphics] -- Intel(R) UHD Graphics [0x9bc4]
		Global Memory Size: 24.9 GB
		Local Memory Size: 64.0 KB
		Workgroup Dimensions: 3
		Total Number of Block Threads: 256
		Max WorkGroup Configuration: [256, 256, 256]
		Device OpenCL C version: OpenCL C 3.0

  Tornado device=1:2
	OPENCL --  [Intel(R) CPU Runtime for OpenCL(TM) Applications] -- Intel(R) Core(TM) i9-10885H CPU @ 2.40GHz
		Global Memory Size: 31.1 GB
		Local Memory Size: 32.0 KB
		Workgroup Dimensions: 3
		Total Number of Block Threads: 8192
		Max WorkGroup Configuration: [8192, 8192, 8192]
		Device OpenCL C version: OpenCL C 2.0

Driver: PTX
  Total number of PTX devices  : 1
  Tornado device=2:0
	PTX -- PTX -- NVIDIA GeForce RTX 2060 with Max-Q Design
		Global Memory Size: 5.8 GB
		Local Memory Size: 48.0 KB
		Workgroup Dimensions: 3
		Total Number of Block Threads: 2147483647
		Max WorkGroup Configuration: [1024, 1024, 64]
		Device OpenCL C version: N/A

```
