# ripe-atlas-sw-probe-packer
Create a RIPE ATLAS software probe using packer for Raspberry PI

## Introduction

This packer is based on the [packer builder](https://github.com/mkaczanowski/packer-builder-arm)
script for Raspberry PI.

Then, I follow the steps included for Debian in the [RIPE Atlas software documentation](https://github.com/RIPE-NCC/ripe-atlas-software-probe/blob/master/INSTALL.rst)

## Preparing the environment

### Install dependencies
Install the packages in the host system, for example, for Debian/Ubuntu:

```
sudo apt-get install git unzip qemu-user-static e2fsprogs dosfstools
```

### Install Packer
Install **Packer**. I use the official Packer, because the included in Debian
is not working fine. You can download the latest version from [https://releases.hashicorp.com/packer/](https://releases.hashicorp.com/packer/)

Download it, save, unzip and copy the binary to `/usr/local/bin`.

```
sudo mv packer /usr/local/bin/
```

### Install packer-builder-arm
Now install **packer-builder-arm**, that is a program to build images for ARM.

You can download using git:

```
git clone https://github.com/mkaczanowski/packer-builder-arm
```

Now, build it using `go`:

```
cd packer-builder-arm
go mod download
go build
```

Copy the binary `packer-builder-arm` to the same place of `packer`,
for example `/usr/local/bin`:

```
sudo cp packer-builder-arm /usr/local/bin/
```

## Build the Atlas image

Download [this code](https://github.com/thekix/ripe-atlas-sw-probe-packer.git)
and run packer:

```
git clone https://github.com/thekix/ripe-atlas-sw-probe-packer.git
cd ripe-atlas-sw-probe-packer
sudo packer build ripe-atlas-sw-probe-packer.json
```

_NOTE: If you have problems with the Packer builder about binmfts and
the qemu-arm-static related execution, try this:_

```
sudo update-binfmts --package qemu-user-static --install qemu-arm /usr/bin/qemu-arm-static --magic "\x7f\x45\x4c\x46\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00" --mask "\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff" --offset 0 --credential yes  --fix-binary yes
```

After the build, you will have the new image `ripe-atlas-sw-probe.img`
Copy the image with `dd` to you SD card. Is something like:

```
dd if=ripe-atlas-sw-probe.img of=/dev/yourSDcard
```

## First startup

In the first startup the script will connect with RIPE Atlas infrastructure
and will generate the keys.  The public key is stored in `/var/atlas-probe/etc/probe_key.pub`.

Register your probe at [https://atlas.ripe.net/apply/swprobe/](https://atlas.ripe.net/apply/swprobe/)

_NOTE: The file `/etc/rc.local` contains the script for this first startup.
If you want, you can edit the file and remove the line about Atlas._
