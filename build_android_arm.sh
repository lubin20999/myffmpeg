#!/bin/bash
echo $1
if [ ! -n "$1" ] ;then
    export TMPDIR=$PWD/tmpdir
else
    export TMPDIR=$1/tmpdir
fi
NDK=$ANDROID_BUILD_TOP/prebuilts/ndk/r11
SYSROOT=$NDK/platforms/android-24/arch-arm/
echo $ANDROID_TOOLCHAIN

CPU=arm
PREFIX=/$PWD/out/arm/
ADDI_CFLAGS="-marm"

function build_one
{
./configure \
--prefix=$PREFIX \
--enable-shared \
--disable-static \
--disable-doc \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-doc \
--disable-symver \
--disable-network \
--disable-decoder=hevc \
--enable-small \
--cross-prefix=$ANDROID_TOOLCHAIN_2ND_ARCH/arm-linux-androideabi- \
--target-os=linux \
--arch=arm \
--enable-cross-compile \
--sysroot=$SYSROOT \
--extra-cflags="-Os -fpic $ADDI_CFLAGS" \
--extra-ldflags="$ADDI_LDFLAGS" \
$ADDITIONAL_CONFIGURE_FLAG
make clean
make
make install
}

build_one
