#!/usr/bin/env bash

# Get an updated config.sub and config.guess
cp -r ${BUILD_PREFIX}/share/libtool/build-aux/config.* ./build-aux

./configure --prefix=$PREFIX

make -j$CPU_COUNT
make install -j$CPU_COUNT
