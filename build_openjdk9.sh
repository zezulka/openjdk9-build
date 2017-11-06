#!/bin/bash
set -xeu
EXTRA_CFLAGS="-fstack-protector-strong -Wno-error -fno-strict-aliasing -fno-delete-null-pointer-checks -fno-lifetime-dse"
EXTRA_CXX_FLAGS="-Wno-error -std=gnu++98 -fno-delete-null-pointer-checks -fno-lifetime-dse -fpermissive"
DEBUGLEVEL=slowdebug
BUILDVER=254
OPENJDK9_DIR="${HOME}/Projects/jdk9"
NUM_PROC=1
MAKE_TARGET=images

cd ${OPENJDK9_DIR}
rm -rf build
bash configure --with-version-build=${BUILDVER} \
    --with-version-pre="" \
    --with-version-opt="" \
    --with-boot-jdk=/usr/lib/jvm/java-1.8.0-openjdk \
    --with-debug-level=$DEBUGLEVEL \
    --with-native-debug-symbols=internal \
    --enable-unlimited-crypto \
    --with-stdc++lib=dynamic \
    --with-extra-cxxflags="$EXTRA_CXX_FLAGS" \
    --with-extra-cflags="$EXTRA_CFLAGS" \
    --with-num-cores="$NUM_PROC" \
    --disable-javac-server \
    --disable-warnings-as-errors

make ${MAKE_TARGET}
