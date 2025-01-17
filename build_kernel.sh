
#!/bin/bash

export PATH=/home/chanz22/Imagens/aarch64-linux-android-4.9/bin:$PATH
# export SEC_BUILD_OPTION_HW_REVISION=02

mkdir out

make -C $(pwd) O=$(pwd)/out ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android VARIANT_DEFCONFIG=sdm450_sec_j8y18lte_swa_open_defconfig sdm450_sec_defconfig SELINUX_DEFCONFIG=selinux_defconfig SELINUX_LOG_DEFCONFIG=selinux_log_defconfig 

make -j12 -C $(pwd) O=$(pwd)/out ARCH=arm64 CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android

IMAGE="out/arch/arm64/boot/Image.gz-dtb"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))

if [[ -f "$IMAGE" ]]; then
	rm AnyKernel3/*.zip > /dev/null 2>&1
	cp $IMAGE AnyKernel3/Image.gz-dtb
	cd AnyKernel3
	zip -r9 Kernel-J8-beta.zip .
fi

