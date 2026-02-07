# Создание кастомного дистрибутива

Пошаговая инструкция по созданию кастомного дистрибутива **Debian 12 KDE**. 
(ОСПС - Операционная система «под себя»)


Используем метод **`mmdebstrap`**.

### 1. Подготовка основной системы

Выполните в терминале вашего компьютера (под обычным пользователем):

```
# Установка необходимых инструментов
sudo apt update
sudo apt install mmdebstrap xorriso genisoimage isolinux syslinux-common \
     mtools libisoburn1 squashfs-tools qemu-system-x86 -y

# Создание рабочей директории в корне (чтобы избежать проблем с правами)
sudo mkdir -p /build-distro
sudo chown $USER:$USER /build-distro
cd /build-distro
```



------

### 2. Сборка базовой системы (Bootstrap)

Эта команда скачает и распакует Debian Bookworm с KDE и вашими пакетами:


Вот максимально полный вариант команды для создания полноценной Live-системы. Я добавил **SDDM**, поддержку **Wi-Fi**, драйверы и необходимые QML-компоненты, чтобы рабочий стол сразу выглядел «по-человечески».

```
sudo rm -rf /build-distro/chroot && \
sudo mmdebstrap --architecture=amd64 \
--components="main,contrib,non-free,non-free-firmware" \
--include="linux-image-amd64,live-boot,systemd-sysv,sudo,locales,network-manager,plasma-nm,firefox-esr,task-russian,task-russian-desktop,desktop-base, \
kde-standard,plasma-desktop,plasma-workspace,sddm,kwin-x11,kinit, \
plasma-framework,qml-module-qtquick-layouts,qml-module-qtquick-controls2,qml-module-qtquick-window2, \
qml-module-org-kde-qqc2desktopstyle,qml-module-org-kde-kirigami2,qml-module-org-kde-kio, \
plasma-widgets-addons,libqt5svg5,libqt5gui5,breeze-icon-theme,desktop-file-utils, \
xserver-xorg-core,xserver-xorg-video-all,xserver-xorg-input-all, \
firmware-linux,firmware-linux-nonfree,firmware-iwlwifi,firmware-realtek,wpasupplicant" \
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

1. Записать ISO на флешку: `sudo dd if=~/my_distro.iso of=/dev/sdX status=progress` (где **sdX** — ваша флешка).
2. Если всё работает, удалите рабочую папку: `sudo rm -rf /build-distro`.



Хотели бы вы, чтобы я добавил в эту инструкцию шаги по установке **инсталлятора Calamares**, чтобы систему можно было устанавливать на диск?

---

---


```
Could not access KVM kernel module:
No such file or directoryqemu-system-x86_64:
failed to initialize kvm:
No such file or directory
```

Вы получили эту ошибку, потому что модули виртуализации KVM не загружены или не поддерживаются вашим процессором (или отключены в BIOS/UEFI).
 
Вот как это исправить:

ОК, у вас ноутбук **Lenovo Ideapad 110-15IBR** с процессором **Intel Pentium N3710**.

Этот процессор *поддерживает* аппаратную виртуализацию Intel VT-x, но она, скорее всего, **отключена в BIOS** вашего ноутбука по умолчанию, поэтому вы и видите ошибку `Operation not supported`.

Инструкции по включению виртуализации (VT-x) в BIOS:

Чтобы KVM заработал, вам необходимо выполнить следующие шаги:

1. **Перезагрузите** ваш ноутбук Lenovo.
2. Во время загрузки, как только появится логотип Lenovo, нажимайте клавишу для входа в BIOS/UEFI Setup. Обычно это **`F2`** или **`Fn + F2`** (иногда может быть `Delete`, `F1` или специальная кнопка Novo на корпусе).
   - *Совет:* Если не получается, при включенном ноутбуке нажмите и удерживайте  кнопку питания до выключения, затем нажмите маленькую кнопку Novo  (обычно рядом с разъемом питания или на боковой панели) и выберите **BIOS Setup** в появившемся меню.
3. Оказавшись в BIOS Utility, перейдите в раздел **`Configuration`** (Конфигурация) или **`Advanced`** (Дополнительно).
4. Найдите пункт с названием **`Intel Virtual Technology`**, **`Intel VT-x`**, **`Virtualization`** или **`VT-d`**.
5. Измените его состояние с **`Disabled`** на **`Enabled`**.
6. Перейдите во вкладку **`Exit`** (Выход).
7. Выберите **`Exit Saving Changes`** или **`Save changes and exit`** (Сохранить изменения и выйти).
8. Ноутбук перезагрузится.



После перезагрузки, когда система Debian загрузится, выполните снова ваши команды:

```
sudo modprobe kvm_intel 
# Эта команда теперь должна выполниться без ошибок
grep -Eoc '(vmx|svm)' /proc/cpuinfo 
# Теперь результат должен быть 1 или больше
```

После этого ваша команда запуска QEMU с KVM должна работать:

```
qemu-system-x86_64 -enable-kvm -m 2G -cdrom ~/my_distro.iso
```

Если у вас возникнут проблемы с поиском нужного пункта в меню BIOS, я могу  поискать конкретные скриншоты меню для вашей модели ноутбука.


