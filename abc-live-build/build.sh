#!/bin/bash
set -e

# Полная очистка
sudo lb clean --all

lb config \
    --apt-http-proxy "http://127.0.0.1:3142" \
    --distribution trixie \
    --architectures amd64 \
    --apt-recommends true \
    --archive-areas "main contrib non-free non-free-firmware" \
    --cache true \
    --bootappend-live "boot=live components locales=ru_RU.UTF-8 keyboard-layouts=ru,us keyboard-variants=, keyboard-options=grp:alt_shift_toggle" \
    --memtest memtest86+

# Запустить сборку и перенаправить вывод в файл
sudo lb build 2>&1 | tee build_log.txt
