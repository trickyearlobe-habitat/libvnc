pkg_name=libvnc
pkg_origin=trickyearlobe
pkg_version="0.9.12"
pkg_maintainer="Richard Nixon <richard.nixon@btinternet.com>"
pkg_description="libvncserver and libvnc client libraries for implementing VNC software"
pkg_upstream_url="https://github.com/LibVNC/libvncserver"
pkg_license=("Apache-2.0")

pkg_filename="LibVNCServer-${pkg_version}.tar.gz"
pkg_dirname="libvncserver-LibVNCServer-${pkg_version}"
pkg_source="https://github.com/LibVNC/LibVNCServer/archive/${pkg_filename}"
pkg_shasum="33cbbb4e15bb390f723c311b323cef4a43bcf781984f92d92adda3243a116136"

pkg_deps=(
  core/glibc
  core/zlib
  core/lzo
  core/libjpeg-turbo
  core/libpng
  trickyearlobe/sdl2
  core/openssl
  core/gnutls
  core/systemd
)

pkg_build_deps=(
  core/make
  core/cmake
  core/pkg-config
  core/gcc
  core/git
  core/libtool
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)
# pkg_interpreters=(bin/bash)

do_begin() {
  do_default_begin
}

do_download() {
  do_default_download
}

do_verify() {
  do_default_verify
}

do_clean() {
  do_default_clean
}

do_unpack() {
  do_default_unpack
}

do_prepare() {
  do_default_prepare
}

do_build() {
  # Having to supply paths to CMAKE as auto package detection seems not to be working
  # Compiles fine outside Hab with OS CMAKE so suspect a problem with core/cmake
  cmake ${HAB_CACHE_SRC_PATH}/${pkg_dirname} \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DSDL2_LIBRARY=$(pkg_path_for trickyearlobe/sdl2)/lib/libSDL2.so \
    -DSDL2_INCLUDE_DIR=$(pkg_path_for trickyearlobe/sdl2)/include/SDL2 \
    -DZLIB_LIBRARY=$(pkg_path_for core/zlib)/lib/libz.so \
    -DZLIB_INCLUDE_DIR=$(pkg_path_for core/zlib)/include \
    -DJPEG_LIBRARY=$(pkg_path_for core/libjpeg-turbo)/lib/libjpeg.so \
    -DJPEG_INCLUDE_DIR=$(pkg_path_for core/libjpeg-turbo)/include \
    -DPNG_LIBRARY=$(pkg_path_for core/libpng)/lib/libpng.so \
    -DPNG_PNG_INCLUDE_DIR=$(pkg_path_for core/libpng)/include \
    -DGnuTLS_LIBRARY=$(pkg_path_for core/gnutls)/lib/libgnutls.so \
    -DGnuTLS_INCLUDE_DIR=$(pkg_path_for core/gnutls)/include/gnutls

    ## Seems to be some problem with core/lzo.
    ## Possibly its actually lzo2 instead of lzo ?
    ## In any case, we seem to be doing OK with core/zlib instead
    # -DLZO_LIBRARY=$(pkg_path_for core/lzo)/lib/liblzo2.so \
    # -DLZO_INCLUDE_DIR=$(pkg_path_for core/lzo)/include/lzo \
}

do_check() {
  ctest   cmake ${HAB_CACHE_SRC_PATH}/${pkg_dirname} --output-on-failure
}

do_install() {
  do_default_install
}

do_strip() {
  do_default_strip
}

do_end() {
  do_default_end
}
