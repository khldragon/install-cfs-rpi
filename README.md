# install-cfs-rpi
install-cfs-rpi is a script that downloads and sets up NASA's Core Flight System on a Raspberry Pi. It modifies the installation from the [cFS source](https://github.com/nasa/cfe) to remove the compiler flags unrecognized by gcc on the Pi and increase the message queue size.

## Usage
```shell
$ source install-cfs-rpi.sh
```

## Running cFS
After running the above installation command, run cFS using:
```shell
$ sudo ./cFE/build/cpu1/exe/core-linux.bin
```
