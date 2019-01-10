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
--disable-avdevice --disable-devices --disable-filters --disable-demuxer=srt --disable-demuxer=microdvd --disable-demuxer=jacosub \
--disable-demuxer=sami --disable-demuxer=realtext --disable-demuxer=dts --disable-demuxer=subviewer --disable-demuxer=subviewer1 \
--disable-demuxer=pjs --disable-demuxer=vplayer --disable-demuxer=mpl2 --disable-decoder=ass --disable-decoder=srt \
--disable-decoder=subrip     --disable-decoder=microdvd --disable-decoder=jacosub --disable-decoder=sami \
--disable-decoder=realtext --disable-decoder=movtext --disable-decoder=subviewer \
--disable-decoder=subviewer1 --disable-decoder=pjs --disable-decoder=vplayer --disable-decoder=mpl2 \
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
