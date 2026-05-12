#!/bin/bash
set -e

echo "[1/3] Установка apt-cacher-ng..."
sudo apt update && sudo apt install -y apt-cacher-ng

echo "[2/3] Настройка конфигурации..."
# Разрешаем кэширование всех репозиториев (включая HTTPS через перенаправление)
sudo sed -i 's/# PassThroughPattern:.*$/PassThroughPattern: .*/' /etc/apt-cacher-ng/acng.conf

echo "[3/3] Перезапуск службы..."
sudo systemctl restart apt-cacher-ng

# Получаем локальный IP адрес
LOCAL_IP=$(hostname -I | awk '{print $1}')

echo "-------------------------------------------------------"
echo "Локальное зеркало-кэш настроено!"
echo "Адрес вашего зеркала: http://$LOCAL_IP:3142"
echo "Теперь пакеты будут скачиваться один раз и храниться в /var/cache/apt-cacher-ng"
echo "-------------------------------------------------------"
