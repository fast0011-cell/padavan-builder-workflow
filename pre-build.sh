#!/usr/bin/env bash

# Точный путь к конфигу ядра внутри сборочного окружения shvchk
KERNEL_CONFIG="/opt/rt-n56u/trunk/configs/boards/MI-3G/kernel-3.4.x.config"

# Делаем замену 256 на 512 прямо в контейнере
if [ -f "$KERNEL_CONFIG" ]; then
    echo "Found kernel config at: $KERNEL_CONFIG"
    sed -i 's/CONFIG_RT2880_DRAM_256M=y/# CONFIG_RT2880_DRAM_256M is not set/' "$KERNEL_CONFIG"
    sed -i 's/# CONFIG_RT2880_DRAM_512M is not set/CONFIG_RT2880_DRAM_512M=y/' "$KERNEL_CONFIG"
    sed -i 's/CONFIG_RALINK_RAM_SIZE=256/CONFIG_RALINK_RAM_SIZE=512/' "$KERNEL_CONFIG"
    echo "SUCCESS: Kernel config successfully patched for 512MB RAM!"
else
    echo "ERROR: Kernel config file not found inside container!"
    exit 1
fi