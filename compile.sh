BASEDIR=/home/user/android_stuff
export STRIP="/home/user/android-ndk-r10e/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-strip"
case $1 in
[1-9])
export CC="/home/user/android-ndk-r10e/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc --sysroot=/home/user/android-ndk-r10e/platforms/android-$1/arch-arm/"
export CXX="/home/user/android-ndk-r10e/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-g++ --sysroot=/home/user/android-ndk-r10e/platforms/android-$1/arch-arm/ -I/home/user/android-ndk-r10e/sources/cxx-stl/gnu-libstdc++/4.9/include -I/home/user/android-ndk-r10e/sources/cxx-stl/gnu-libstdc++/4.9/libs/armeabi/include/ -I /home/user/android-ndk-r10e/sources/cxx-stl/stlport/stlport/ "
#export LD="/home/user/android-ndk-r10e/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-ld --sysroot=/home/user/android-ndk-r10e/platforms/android-$1/arch-arm/"
;;
[1-9][1-9])
export CC="/home/user/android-ndk-r10e/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc --sysroot=/home/user/android-ndk-r10e/platforms/android-$1/arch-arm/"
export CXX="/home/user/android-ndk-r10e/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-g++ --sysroot=/home/user/android-ndk-r10e/platforms/android-$1/arch-arm/ -I/home/user/android-ndk-r10e/sources/cxx-stl/gnu-libstdc++/4.9/include -I/home/user/android-ndk-r10e/sources/cxx-stl/gnu-libstdc++/4.9/libs/armeabi/include/ -I /home/user/android-ndk-r10e/sources/cxx-stl/stlport/stlport/ "
#export LD="/home/user/android-ndk-r10e/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86/bin/arm-linux-androideabi-ld --sysroot=/home/user/android-ndk-r10e/platforms/android-$1/arch-arm/"
;;
*)
echo YOU MUST RUN THIS SCRIPT WITH THE SOURCE COMMAND\!\!
echo $"Usage: source $0 android-abi-level arm-arch{6|6-nofpu|7|7-pie}"
esac
case $2 in
6)
export ARCH_FLAGS="-marm -march=armv6 -mfloat-abi=softfp -L$BASEDIR/armv6_lib -I$BASEDIR/armv6_inc"
export ARCH_LINK="-march=armv6 -flto --gc-sections -L$BASEDIR/armv6_lib -I$BASEDIR/armv6_inc"
;;
"6-nofpu")
export ARCH_FLAGS="-marm -march=armv6 -mfloat-abi=soft -L$BASEDIR/armv6-nofpu_lib -I$BASEDIR/armv6-nofpu_inc"
export ARCH_LINK="-march=armv6 -flto --gc-sections -L$BASEDIR/armv6-nofpu_lib -I$BASEDIR/armv6-nofpu_inc"
;;
7)
export ARCH_FLAGS="-marm -march=armv7-a -mfpu=neon -mfloat-abi=hard -mhard-float -D_NDK_MATH_NO_SOFTFP=1 -ftree-vectorize -mvectorize-with-neon-quad -ftree-vectorizer-verbose=2 -funsafe-math-optimizations -Wl,--gc-sections,-lm_hard,--no-warn-mismatch -L$BASEDIR/armv7_lib -I$BASEDIR/armv7_inc"
export ARCH_LINK="-march=armv7-a -flto --gc-sections -lm_hard --no-warn-mismatch -L$BASEDIR/armv7_lib -I$BASEDIR/armv7_inc"
;;
"7-pie")
export ARCH_FLAGS="-marm -march=armv7-a -pie -mfpu=neon -mfloat-abi=hard -mhard-float -D_NDK_MATH_NO_SOFTFP=1 -ftree-vectorize -mvectorize-with-neon-quad -ftree-vectorizer-verbose=2 -funsafe-math-optimizations -Wl,--gc-sections,-lm_hard,--no-warn-mismatch -L$BASEDIR/armv7_lib -I$BASEDIR/armv7_inc"
export ARCH_LINK="-march=armv7-a -flto --gc-sections -lm_hard --no-warn-mismatch -L$BASEDIR/armv7-pie_lib -I$BASEDIR/armv7-pie_inc"
;;
*)
echo YOU MUST RUN THIS SCRIPT WITH THE SOURCE COMMAND\!\!
echo $"Usage: source $0 android-abi-level arm-arch{6|6-nofpu|7|7-pie}"
;;
esac
export CPPFLAGS=" ${ARCH_FLAGS} -pipe -fPIE -fomit-frame-pointer -flto -O3 -Wl,--gc-sections -ffunction-sections"
export CXXFLAGS=" ${ARCH_FLAGS} -pipe -fPIE -fomit-frame-pointer -flto -O3 -Wl,--gc-sections -ffunction-sections"
export CFLAGS=" ${ARCH_FLAGS} -pipe -fPIE -fomit-frame-pointer -flto -O3 -Wl,--gc-sections -ffunction-sections"
export LDFLAGS=" ${ARCH_LINK}"
