#!/usr/bin/env bash

# Универсальный поиск файла конфигурации ядра для MI-3G в shvchk
KERNEL_CONFIG=$(find . -name "kernel-3.4.x.config" | grep "MI-3G" | head -n 1)

# Проверяем, нашел ли скрипт файл, и меняем 256МБ на 512МБ
if [[ -n "$KERNEL_CONFIG" && -f "$KERNEL_CONFIG" ]]; then
    echo "Found kernel config at: $KERNEL_CONFIG"
    sed -i 's/CONFIG_RT2880_DRAM_256M=y/# CONFIG_RT2880_DRAM_256M is not set/' "$KERNEL_CONFIG"
    sed -i 's/# CONFIG_RT2880_DRAM_512M is not set/CONFIG_RT2880_DRAM_512M=y/' "$KERNEL_CONFIG"
    sed -i 's/CONFIG_RALINK_RAM_SIZE=256/CONFIG_RALINK_RAM_SIZE=512/' "$KERNEL_CONFIG"
    echo "SUCCESS: Kernel config patched for 512MB RAM!"
else
    echo "ERROR: Kernel config file for MI-3G not found!"
    exit 1
fi
