# libvnc

A Habitat plan to build:-

* libvncclient library
* libvncserver library

## Maintainers

Richard Nixon <richard.nixon@btinternet.com>

## Usage

Create a Habitat plan in the source code directory for your application

``` bash
hab plan init
```

Then add libvnc as a dependency

``` bash
pkg_deps=(core/glibc trickyearlobe/libvnc)
```
