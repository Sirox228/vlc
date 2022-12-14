NDK=$ANDROID_NDK_HOME

# specify this one to your os on which you run compilation
HOST_OS=linux-x86_64

echo "compiling for architecture: $1"

cd libvlc

./bootstrap # this is same as autogen.sh, idk why they named it like that in libvlc

case "$1" in
    clean)
        make clean
        ;;
    armv7-a)
        export CFLAGS="-m32 -O2"
        export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_OS
        export TARGET=armv7a-linux-androideabi
        export API=19
        export AR=$TOOLCHAIN/bin/llvm-ar
        export CC=$TOOLCHAIN/bin/$TARGET$API-clang
        # if needed, you can try setting this as $CC or you can steal GAS AS from old ndk such as r15c and point to it there
        export AS=$TOOLCHAIN/bin/llvm-as
        export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
        export LD=$TOOLCHAIN/bin/ld
        export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
        export STRIP=$TOOLCHAIN/bin/llvm-strip
        ./configure --host $TARGET --disable-debug --disable-lua --enable-omxil --enable-fdkaac --enable-vorbis --enable-gles2 --disable-qt
        make
        ;;
    armv8-a)
        export CFLAGS="-m64 -O2"
        export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_OS
        export TARGET=aarch64-linux-android
        export API=21
        export AR=$TOOLCHAIN/bin/llvm-ar
        export CC=$TOOLCHAIN/bin/$TARGET$API-clang
        # if needed, you can try setting this as $CC or you can steal GAS AS from old ndk such as r15c and point to it there
        export AS=$TOOLCHAIN/bin/llvm-as
        export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
        export LD=$TOOLCHAIN/bin/ld
        export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
        export STRIP=$TOOLCHAIN/bin/llvm-strip
        ./configure --host $TARGET --disable-debug --disable-lua --enable-omxil --enable-fdkaac --enable-vorbis --enable-gles2 --disable-qt
        make
        ;;
    x86-android)
        export CFLAGS="-m32 -O2"
        export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_OS
        export TARGET=i686-linux-android
        export API=19
        export AR=$TOOLCHAIN/bin/llvm-ar
        export CC=$TOOLCHAIN/bin/$TARGET$API-clang
        # if needed, you can try setting this as $CC or you can steal GAS AS from old ndk such as r15c and point to it there
        export AS=$TOOLCHAIN/bin/llvm-as
        export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
        export LD=$TOOLCHAIN/bin/ld
        export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
        export STRIP=$TOOLCHAIN/bin/llvm-strip
        ./configure --host $TARGET --disable-debug --disable-lua --enable-omxil --enable-fdkaac --enable-vorbis --enable-gles2 --disable-qt
        make
        ;;
    x86_64-android)
        export CFLAGS="-m64 -O2"
        export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/$HOST_OS
        export TARGET=x86_64-linux-android
        export API=21
        export AR=$TOOLCHAIN/bin/llvm-ar
        export CC=$TOOLCHAIN/bin/$TARGET$API-clang
        # if needed, you can try setting this as $CC or you can steal GAS AS from old ndk such as r15c and point to it there
        export AS=$TOOLCHAIN/bin/llvm-as
        export CXX=$TOOLCHAIN/bin/$TARGET$API-clang++
        export LD=$TOOLCHAIN/bin/ld
        export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
        export STRIP=$TOOLCHAIN/bin/llvm-strip
        ./configure --host $TARGET --disable-debug --disable-lua --enable-omxil --enable-fdkaac --enable-vorbis --enable-gles2 --disable-qt
        make
        ;;
    x86_64-linux)
        export CFLAGS="-m64 -O2"
        ./configure --disable-debug --disable-lua --enable-omxil --enable-fdkaac --enable-vorbis --enable-gles2 --disable-qt
        make
        ;;
    x86-linux)
        export CFLAGS="-m32 -O2"
        ./configure --disable-debug --disable-lua --enable-omxil --enable-fdkaac --enable-vorbis --enable-gles2 --disable-qt
        make
        ;;
    *)
        echo "you didn't specify an architecture or specified invalid one (available options: armv7-a, armv8-a, x86-android, x86_64-android, x86_64-linux)"
        exit 1
        ;;
esac