
#!/bin/bash

make clean && make mrproper

export PATH=/home/chanz22/tc/gcc-linaro-6.5.0/bin:$PATH
# export SEC_BUILD_OPTION_HW_REVISION=02

mkdir out

make -C $(pwd) O=$(pwd)/out ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- VARIANT_DEFCONFIG=j8y18lte_defconfig sdm450_sec_defconfig SELINUX_DEFCONFIG=selinux_defconfig SELINUX_LOG_DEFCONFIG=selinux_log_defconfig

make -j12 -C $(pwd) O=$(pwd)/out ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-

IMAGE="out/arch/arm64/boot/Image.gz"
DTB_OUT="out/arch/arm64/boot/Image.gz-dtb"

if [[ -f "$IMAGE" ]]; then
	rm AnyKernel3/*.zip > /dev/null 2>&1
	cp $IMAGE AnyKernel3/Image.gz
	cp $DTB_OUT AnyKernel3/Image.gz-dtb
	cd AnyKernel3
	zip -r9 Kernel-J8-beta.zip .
fi

