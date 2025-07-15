# edl container.

basically a container for [bkerler/edl](https://github.com/bkerler/edl) program.

because you hate waiting for its dependencies to get compiled.

```
mkdir $PWD/shared
[c] pull ghcr.io/yonle/edl-container:master
[c] create --name edl -v /dev/bus/usb:/dev/bus/usb -v $PWD/shared:/mnt ghcr.io/yonle/edl-container:master sleep Infinity
[c] start edl
```

(where `[c]` could be [`docker`](https://docker.com) or [`podman`](https://podman.io))

then, you need to configure udev:

```
[c] cp edl:/root/misc/Drivers .
[c] cp edl:/root/misc/install-linux-edl-drivers.sh .
./install-linux-edl-drivers.sh
```

---

finally, just run `[c] start edl` and then `[c] exec -it edl su -l`

then do your normal `edl`, `adb`, or `fastboot` activities inside here...

## shared folder

the current directory has `shared` directory, where in the container is mounted to `/mnt`.

to put it simply, if you have a file to flash (say, `flash.bin`), just put it inside `shared/` folder, and then flash it:
```
edl wf /mnt/flash.bin
```

or if you wanna dump it,
```
edl rf /mnt/dump.bin
```

you will see `dump.bin` inside the `shared/` folder.

## why edl-container

```
[+] Building 190.1s (6/6) FINISHED
```

normal installation took **190.1 seconds** to finish on gcloud with 4 cores of CPUs. imagine the time will took to install `edl` on a celeron machine.

on top of that, post-install size took **more storage** if done without additional cache purging & etc.

```
REPOSITORY   TAG       IMAGE ID       CREATED              SIZE
normal       latest    db64b628580e   About a minute ago   1.59GB
yonle/edl    latest    f6d3b5503004   11 hours ago         472MB
```
