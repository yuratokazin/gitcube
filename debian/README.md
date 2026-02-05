# Создание кастомного дистрибутива

Пошаговая инструкция по созданию кастомного дистрибутива **Debian 12 KDE**. 
(ОСПС - Операционная система «под себя»)

Используем метод **`mmdebstrap`**.

### 1. Подготовка основной системы

Выполните в терминале вашего компьютера (под обычным пользователем):

```
# Установка необходимых инструментов
sudo apt update
sudo apt install mmdebstrap genisoimage isolinux syslinux-common \
     mtools libisoburn1 squashfs-tools qemu-system-x86 -y

# Создание рабочей директории в корне (чтобы избежать проблем с правами)
sudo mkdir -p /build-distro
sudo chown $USER:$USER /build-distro
cd /build-distro
```



------

### 2. Сборка базовой системы (Bootstrap)

Эта команда скачает и распакует Debian Bookworm с KDE и вашими пакетами:

```
sudo rm -rf /build-distro/chroot && \
sudo mmdebstrap --architecture=amd64 \
--include="task-kde-desktop,kde-standard,network-manager,plasma-nm,firefox-esr,linux-image-amd64,live-boot,systemd-sysv,sudo,locales,task-russian,task-russian-desktop,kwin-x11,kwin-common,kwin-style-breeze,kded5,kinit,qml-module-org-kde-kcm,desktop-file-utils,breeze-icon-theme,desktop-base" \
--customize-hook='chroot "$1" sh -c "echo \"ru_RU.UTF-8 UTF-8\" > /etc/locale.gen && locale-gen"' \
--customize-hook='chroot "$1" sh -c "echo \"LANG=ru_RU.UTF-8\" > /etc/default/locale"' \
--customize-hook='chroot "$1" sh -c "echo root:admin | chpasswd"' \
--customize-hook='chroot "$1" sh -c "useradd -m -s /bin/bash user && echo user:admin | chpasswd && adduser user sudo"' \
bookworm /build-distro/chroot http://mirror.yandex.ru/debian/
```



------

### 3. Настройка внутри системы (Chroot)

#### Настроим пользователя, язык и кнопки окон

```
# Монтируем системные пути
sudo mount --bind /dev /build-distro/chroot/dev
sudo mount --bind /proc /build-distro/chroot/proc
sudo mount --bind /sys /build-distro/chroot/sys

# Заходим внутрь системы
sudo chroot /build-distro/chroot /bin/bash
```

#### Внутри chroot (выполняйте по очереди)

```
# 1. Настройка локали (Русский язык)
echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=ru_RU.UTF-8" > /etc/default/locale

# 2. Настройка клавиатуры (Alt+Shift)
cat <<EOF > /etc/default/keyboard
XKBMODEL="pc105"
XKBLAYOUT="us,ru"
XKBVARIANT=""
XKBOPTIONS="grp:alt_shift_toggle,grp_led:scroll"
BACKSPACE="guess"
EOF

# 3. Создание пользователя (замените 'admin' на свой пароль)
useradd -m -s /bin/bash user
echo "user:admin" | chpasswd
usermod -aG sudo user

# 4. Настройка автологина в KDE
mkdir -p /etc/sddm.conf.d
cat <<EOF > /etc/sddm.conf.d/autologin.conf
[Autologin]
User=user
Session=plasma
EOF

# 5. Обновление кэшей
update-mime-database /usr/share/mime
update-desktop-database /usr/share/applications

# Выход из системы
exit
```

#### Размонтирование (ОБЯЗАТЕЛЬНО)

```
sudo umount -l /build-distro/chroot/dev
sudo umount -l /build-distro/chroot/proc
sudo umount -l /build-distro/chroot/sys
```



------

### 4. Создание загрузочного ISO

Теперь упаковываем всё в файл.

#### Сжатие системы (SquashFS)

```
mkdir -p /build-distro/iso/live
mkdir -p /build-distro/iso/isolinux

# Копируем ядро и initrd
sudo cp /build-distro/chroot/boot/vmlinuz-* /build-distro/iso/live/vmlinuz
sudo cp /build-distro/chroot/boot/initrd.img-* /build-distro/iso/live/initrd

# Сжимаем файловую систему
sudo mksquashfs /build-distro/chroot /build-distro/iso/live/filesystem.squashfs -comp xz -e boot
```

#### Настройка меню загрузки

```
cat <<EOF > /build-distro/iso/isolinux/isolinux.cfg
default live
label live
  say Booting My Custom Debian KDE...
  kernel /live/vmlinuz
  append initrd=/live/initrd boot=live quiet splash
EOF

# Копируем файлы загрузчика
sudo cp /usr/lib/ISOLINUX/isolinux.bin /build-distro/iso/isolinux/
sudo cp /usr/lib/syslinux/modules/bios/ldlinux.c32 /build-distro/iso/isolinux/
sudo cp /usr/lib/syslinux/modules/bios/libcom32.c32 /build-distro/iso/isolinux/
sudo cp /usr/lib/syslinux/modules/bios/libutil.c32 /build-distro/iso/isolinux/
```

#### Финальная сборка ISO

```
sudo xorriso -as mkisofs \
   -iso-level 3 -full-iso9660-filenames \
   -volid "DEBIAN_KDE" \
   -eltorito-boot isolinux/isolinux.bin \
   -eltorito-catalog isolinux/boot.cat \
   -no-emul-boot -boot-load-size 4 -boot-info-table \
   -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
   -output ~/my_distro.iso \
   /build-distro/iso
```



------

### 5. Проверка

Запустите полученный образ:

```
qemu-system-x86_64 -enable-kvm -m 2G -cdrom ~/my_distro.iso
```

**Что вы можете сделать дальше:**

1. Записать ISO на флешку: `sudo dd if=~/my_final_distro.iso of=/dev/sdX status=progress` (где **sdX** — ваша флешка).
2. Если всё работает, удалите рабочую папку: `sudo rm -rf /build-distro`.



Хотели бы вы, чтобы я добавил в эту инструкцию шаги по установке **инсталлятора Calamares**, чтобы систему можно было устанавливать на диск?



