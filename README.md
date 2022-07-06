# xpra-wine
Container of Xpra+wine, useful for demonstration purposes. Packages are installed from each project's repository on a Ubuntu 22.04 base image.

## Versions
* base image: ubuntu:22.04
* xpra: 4.3.4-r0-1
* wine: wine-staging 7.12~jammy-1 (i386 and amd64)

## Quickstart
Run the container with podman or docker:
```
podman run -it --rm -p 14500:14500 -v /path/to/folder-with-executables:/apps pmcnabb/xpra-wine
```

Connect in a browser to `http://localhost:14500/`

Use the xterm to run a program:
```
wine /apps/sample.exe
```
