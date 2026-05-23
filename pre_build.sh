#!/usr/bin/env bash

# Точный путь к файлу конфигурации ядра в padavan-ng
KERNEL_CONFIG="padavan-ng/trunk/configs/boards/MI-3G/kernel-3.4.x.config"

# Проверяем, существует ли файл, и меняем 256МБ на 512МБ
if [ -f "$KERNEL_CONFIG" ]; then
    sed -i 's/CONFIG_RT2880_DRAM_256M=y/# CONFIG_RT2880_DRAM_256M is not set/' "$KERNEL_CONFIG"
    sed -i 's/# CONFIG_RT2880_DRAM_512M is not set/CONFIG_RT2880_DRAM_512M=y/' "$KERNEL_CONFIG"
    sed -i 's/CONFIG_RALINK_RAM_SIZE=256/CONFIG_RALINK_RAM_SIZE=512/' "$KERNEL_CONFIG"
    echo "SUCCESS: Kernel config patched for 512MB RAM!"
else
    echo "ERROR: Kernel config file not found at $KERNEL_CONFIG"
fi
