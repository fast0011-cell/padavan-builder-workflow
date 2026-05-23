#!/usr/bin/env bash

# Умный поиск файла конфигурации ядра MI-3G по всему контейнеру
KERNEL_CONFIG=$(find / -name "kernel-3.4.x.config" 2>/dev/null | grep "MI-3G" | head -n 1)

# Если файл найден — правим его под 512 МБ RAM
if [[ -n "$KERNEL_CONFIG" && -f "$KERNEL_CONFIG" ]]; then
    echo "Found kernel config at: $KERNEL_CONFIG"
    sed -i 's/CONFIG_RT2880_DRAM_256M=y/# CONFIG_RT2880_DRAM_256M is not set/' "$KERNEL_CONFIG"
    sed -i 's/# CONFIG_RT2880_DRAM_512M is not set/CONFIG_RT2880_DRAM_512M=y/' "$KERNEL_CONFIG"
    sed -i 's/CONFIG_RALINK_RAM_SIZE=256/CONFIG_RALINK_RAM_SIZE=512/' "$KERNEL_CONFIG"
    echo "SUCCESS: Kernel config successfully patched for 512MB RAM!"
else
    echo "ERROR: Kernel config file for MI-3G not found anywhere in the container!"
    exit 1
fi