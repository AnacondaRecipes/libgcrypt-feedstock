#!/usr/bin/env bash

# Get an updated config.sub and config.guess
cp -r ${BUILD_PREFIX}/share/libtool/build-aux/config.* ./build-aux

# arm64 macOS: libgcrypt's hand-written AArch64 assembly uses GNU CFI
# directives that Apple's Mach-O assembler rejects ("Unfinished frame!").
# Fall back to the portable C implementation on this platform.
if [[ "$(uname)" == "Darwin" && "$(uname -m)" == "arm64" ]]; then
  EXTRA_CONFIGURE_FLAGS="--disable-asm"
fi

./configure --prefix=$PREFIX $EXTRA_CONFIGURE_FLAGS

make -j$CPU_COUNT
make tests -j$CPU_COUNT
make install -j$CPU_COUNT
