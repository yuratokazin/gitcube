# Git LFS

#### Git LFS помогает загружать файлы более 25 МиБ на github

На Debian, гораздо лучше устанавливать `git-lfs` через пакетный менеджер `apt`. Это обеспечит автоматическое обновление вместе с системой.

```
# Установка через apt
sudo apt update
sudo apt install git-lfs

# Инициализация
git lfs install
```

Проверка

Чтобы убедиться, что Git LFS установлен и работает, введите:

```
git lfs env
```

Эта команда покажет информацию о версии и окружении. 

---

Чтобы всё получилось,  важно понимать: в Git нельзя клонировать отдельную папку по ссылке из  браузера — нужно клонировать весь проект (репозиторий), добавить в него  файл и отправить обратно.

Вот точная последовательность команд для вашего случая:

**Клонируем репозиторий** (именно по этой ссылке):

```
oem@lenovo:~$ git clone https://github.com/yuratokazin/gitcube
Клонирование в «gitcube»...
remote: Enumerating objects: 608, done.
remote: Counting objects: 100% (92/92), done.
remote: Compressing objects: 100% (79/79), done.
remote: Total 608 (delta 34), reused 1 (delta 1), pack-reused 516 (from 1)
Получение объектов: 100% (608/608), 3.89 МиБ | 1.47 МиБ/с, готово.
Определение изменений: 100% (279/279), готово.
oem@lenovo:~$ cd gitcube
oem@lenovo:~/gitcube$ cp /home/oem/Typora-linux-x64.zip Typora/
oem@lenovo:~/gitcube$ git lfs track "Typora/*.zip"
Tracking "Typora/*.zip"
oem@lenovo:~/gitcube$ git add .gitattributes
git add Typora/Typora-linux-x64.zip
oem@lenovo:~/gitcube$ git commit -m "Add Typora-linux-x64.zip using LFS"
[main 3ff106a] Add Typora-linux-x64.zip using LFS
 Committer: oem <oem@localhost.localdomain>
Ваше имя или электронная почта настроены автоматически на основании вашего
имени пользователя и имени машины. Пожалуйста, проверьте, что они 
определены правильно.
Вы можете отключить это уведомление установив их напрямую:

    git config --global user.name "Ваше Имя"
    git config --global user.email you@example.com

После этого, изменить авторство этой коммита можно будет с помощью команды:

    git commit --amend --reset-author

 2 files changed, 4 insertions(+)
 create mode 100644 .gitattributes
 create mode 100644 Typora/Typora-linux-x64.zip
oem@lenovo:~/gitcube$ git push origin main
Username for 'https://github.com': yuratokazin
Password for 'https://yuratokazin@github.com': 
remote: Invalid username or token. Password authentication is not supported for Git operations.
fatal: Authentication failed for 'https://github.com/yuratokazin/gitcube/'
oem@lenovo:~/gitcube$ git push origin main
Username for 'https://github.com': yuratokazin
Password for 'https://yuratokazin@github.com': 
Username for 'https://github.com': yuratokazin
Password for 'https://yuratokazin@github.com': 
Uploading LFS objects: 100% (1/1), 94 MB | 1.7 MB/s, done.                                                   
Перечисление объектов: 7, готово.
Подсчет объектов: 100% (7/7), готово.
При сжатии изменений используется до 8 потоков
Сжатие объектов: 100% (4/4), готово.
Запись объектов: 100% (5/5), 581 байт | 290.00 КиБ/с, готово.
Всего 5 (изменений 1), повторно использовано 0 (изменений 0), повторно использовано пакетов 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/yuratokazin/gitcube
   0d8d71a..3ff106a  main -> main
oem@lenovo:~/gitcube$ 

```



Отлично! Вы уже внутри репозитория. Теперь осталось перенести файл, настроить LFS и отправить изменения.

Выполните следующие команды по порядку:

**Создайте папку Typora** (если она уже есть в репозитории, команда просто ничего не сделает):

```
mkdir -p Typora
```

**Скопируйте ваш архив** из домашней папки в эту новую директорию:

```
cp /home/oem/Typora-linux-x64.zip Typora/
```

**Укажите Git LFS отслеживать этот файл**:

```
git lfs track "Typora/*.zip"
```

**Добавьте изменения в индекс**:

```
git add .gitattributes
git add Typora/Typora-linux-x64.zip
```

**Зафиксируйте изменения (Commit)**:

```
git commit -m "Add Typora-linux-x64.zip using LFS"
```

**Отправьте файл на GitHub**:

```
git push origin main
```

**На шаге `git push` появится запрос пароля.** Напоминаю, что нужно вводить не пароль от сайта, а **Personal Access Token**.

Он у вас уже есть под рукой? Если нет, могу подсказать, в каком разделе настроек GitHub его создать.

`

```
oem@lenovo:~/gitcube$ git push origin main
Username for 'https://github.com': yuratokazin
Password for 'https://yuratokazin@github.com': 
Username for 'https://github.com': yuratokazin
Password for 'https://yuratokazin@github.com': 
Uploading LFS objects: 100% (1/1), 94 MB | 1.7 MB/s, done.                                                   
Перечисление объектов: 7, готово.
Подсчет объектов: 100% (7/7), готово.
При сжатии изменений используется до 8 потоков
Сжатие объектов: 100% (4/4), готово.
Запись объектов: 100% (5/5), 581 байт | 290.00 КиБ/с, готово.
Всего 5 (изменений 1), повторно использовано 0 (изменений 0), повторно использовано пакетов 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/yuratokazin/gitcube
   0d8d71a..3ff106a  main -> main
oem@lenovo:~/gitcube$ 
```



Как и ожидалось, GitHub отклонил обычный пароль. Теперь вам нужно создать **Personal Access Token (PAT)**, который будет служить вашим паролем в терминале.

Как быстро создать токен:

1. Зайдите на GitHub в браузере.
2. Перейдите в **Settings** (нажмите на свое фото справа вверху → Settings).
3. В самом низу левого меню выберите **Developer settings**.
4. Выберите **Personal access tokens** → **Tokens (classic)**.
5. Нажмите **Generate new token** → **Generate new token (classic)**.
6. В поле **Note** напишите, например, `my-pc`.
7. В пункте **Expiration** выберите срок (например, 30 или 90 дней).
8. **Самое важное — галочки (Scopes):** Отметьте галочкой самый первый пункт: **`repo`** (это даст доступ к вашим репозиториям).
9. Прокрутите вниз и нажмите **Generate token**.

**Внимание:** Скопируйте появившийся длинный код (токен) прямо сейчас. Вы больше его не увидите.

Что делать дальше в терминале:

Снова введите команду:

```
git push origin main
```

Используйте код с осторожностью.

1. **Username:** введите `yuratokazin`.
2. **Password:** вставьте (Ctrl+Shift+V в терминале или правой кнопкой мыши) ваш **скопированный токен**. Символы при вводе отображаться не будут.

**Получилось создать токен или возникли трудности на каком-то шаге?**