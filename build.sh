#!/bin/bash
# build wbox

# options
OPT_DEBUG_MODE=0
OPT_INSTALL_DIR=


# check-depends pre condtion
pkg-config --list-all | grep libevent &>/dev/null || { echo "You need install libevent first!!" && exit 1; }


# opts
CMAKE_OPTS=
[ "$OPT_DEBUG_MODE" != 0 ] && CMAKE_OPTS="$CMAKE_OPTS -Ddebug=1"
[ -n "$OPT_INSTALL_DIR" ]  && CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_INSTALL_PREFIX=$OPT_INSTALL_DIR"

# get project home
PROJ_ROOT_HOME=$(pushd `dirname $0` >/dev/null; pwd; popd >/dev/null);
# build tmp dir
WBOX_BUILD_DIR=$PROJ_ROOT_HOME/.build
# release dir
WBOX_RELEASE_DIR=$PROJ_ROOT_HOME/release
[ ! -d "$WBOX_RELEASE_DIR" ] && mkdir -p "$WBOX_RELEASE_DIR"

# verify build dir empty
[ -d "$WBOX_BUILD_DIR" ] && rm -rf "$WBOX_BUILD_DIR"
mkdir -p "$WBOX_BUILD_DIR"
if [ -d "$WBOX_BUILD_DIR" ]; then
    pushd "$WBOX_BUILD_DIR" >/dev/null
        echo "###CMAKE_OPTS=$CMAKE_OPTS"
        cmake $CMAKE_OPTS ../yard/sdk/wbox && make package
        [ -n "$OPT_INSTALL_DIR" ] && make install
        cp *.tar.* "$WBOX_RELEASE_DIR"
    popd >/dev/null
    rm -rf "$WBOX_BUILD_DIR"
fi
