## Установка игры Granny на Debian

### Способ 1: Через Steam Proton

1. **Установка Steam**

- Откройте терминал и выполните команды:

bash

```bash
sudo apt update
sudo apt install steam
```

1. **Настройка Proton**

- После установки Steam запустите его
- Перейдите в **Настройки** → **Steam Play**
- Включите поддержку Proton

1. **Покупка и установка игры**

- Найдите игру Granny в магазине Steam
- Приобретите и установите её
- При выборе версии для установки выберите Proton

### Способ 2: Ручная установка

1. **Подготовка системы**

- Установите необходимые зависимости:

```bash
sudo apt install libgl1-mesa-dev libglu1-mesa-dev libx11-dev libxext-dev libxi-dev
```

1. **Скачивание игры**

- Скачайте игру с официального сайта или Steam
- Распакуйте архив в удобную директорию

1. **Настройка запуска**

- Создайте файл запуска:

```bash
nano granny.sh
```

- Добавьте в файл:

```bash
#!/bin/bash
PROTON_NO_ESYNC=1 %PATH_TO_GAME%/Granny.exe
```

- Сделайте файл исполняемым:

```bash
chmod +x granny.sh
```

### Решение возможных проблем

- Если игра не запускается:
  - Проверьте права доступа к файлам
  - Обновите драйверы видеокарты
  - Убедитесь, что установлены все необходимые библиотеки
- При ошибках совместимости:
  - Попробуйте запустить игру с другим версией Proton
  - Используйте команду:

- ```bash
  PROTON_VERSION=proton-7 PATH_TO_GAME/Granny.exe
  ```

### Дополнительные рекомендации

- Рекомендуется использовать последнюю стабильную версию игры (1.5.5)
- Для лучшей производительности убедитесь, что у вас достаточно оперативной памяти (минимум 4 ГБ)
- При возникновении проблем с графикой попробуйте изменить настройки в файле конфигурации игры

---

---



#### у меня не устанавливаются зависимости требует требует установочный диск с меткой сидиром

Давайте решим проблему с установкой зависимостей в Debian.

### Почему возникает ошибка

Ошибка с требованием установочного диска обычно появляется, если:

- В системе отсутствуют необходимые репозитории
- Поврежден файл источников пакетов
- Неправильно настроены репозитории

### Решение проблемы

1. **Проверка и обновление источников пакетов**

```bash
sudo nano /etc/apt/sources.list
```

Убедитесь, что у вас есть следующие строки (или похожие):

```bash
deb http://deb.debian.org/debian stable main contrib non-free
deb-src http://deb.debian.org/debian stable main contrib non-free

deb http://security.debian.org/debian-security stable/updates main contrib non-free
deb-src http://security.debian.org/debian-security stable/updates main contrib non-free
```

1. **Обновление системы**

```bash
sudo apt update
sudo apt upgrade
```

1. **Установка необходимых компонентов**

```bash
sudo apt install software-properties-common
sudo apt install build-essential
```

1. **Повторная попытка установки зависимостей**

```bash
sudo apt install libgl1-mesa-dev libglu1-mesa-dev libx11-dev libxext-dev libxi-dev
```

### Альтернативные способы установки

Если проблема сохраняется, попробуйте:

1. **Добавить все репозитории**

```bash
sudo add-apt-repository main
sudo add-apt-repository contrib
sudo add-apt-repository non-free
```

1. **Использование команды с принудительной установкой**

```bash
sudo apt-get install -f
sudo apt-get install --reinstall libgl1-mesa-dev libglu1-mesa-dev libx11-dev libxext-dev libxi-dev
```

### Дополнительные рекомендации

- Проверьте подключение к интернету
- Очистите кэш apt:

```bash
sudo apt clean
sudo apt autoclean
```

- Если используете прокси, настройте его:

```bash
export http_proxy="http://ваш_прокси:порт"
export https_proxy="https://ваш_прокси:порт"
```

Если после всех этих действий проблема сохраняется, возможно, стоит:

- Проверить целостность системы: `sudo apt-get check`
- Переустановить менеджер пакетов: `sudo apt-get install --reinstall apt`
- Обновить систему до последней версии: `sudo apt-get dist-upgrade`


  
