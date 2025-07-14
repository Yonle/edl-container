# edl container.

basically a container for [bkerler/edl](https://github.com/bkerler/edl) program.

because you hate waiting for it's dependencies to get compiled.

```
mkdir $PWD/shared
[c] pull ghcr.io/yonle/edl-container:master
[c] create --name edl --privileged --device /dev/ttyUSB0 -v /dev/bus/usb:/dev/bus/usb -v $PWD/shared:/mnt ghcr.io/yonle/edl-container:master sleep Infinity
[c] start edl
```

(where `[c]` could be [`docker`](https://docker.com) or [`podman`](https://podman.io))

you will need to configure udev:

```
[c] copy edl:/root/misc/Drivers .
[c] copy edl:/root/misc/install-linux-edl-drivers.sh .
./install-linux-edl-drivers.sh
```

and then reboot.

---

finally, just run `[c] start edl` and then `[c] exec -it edl su -l`

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
