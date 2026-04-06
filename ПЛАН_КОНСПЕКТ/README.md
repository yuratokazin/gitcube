### Разработать олимпиадные задания по Веб разработке стартовый уровень

Разработка олимпиадных заданий по веб-разработке стартового уровня (для школьников 7–9 классов) должна включать базовые знания 

[HTML5](https://www.google.com/search?q=HTML5&mstk=AUtExfCr0_8YvUEkVbGNjSylq-SW9O1z6Mb4Y-dIbLCzkxCAJOEnc3TnfVlXUfJYWbx5am2bgeUvLkti79kkgt0yPC-q63Wt1TXZJjmXtaJ6iqVKXhayoT5YZXpbsV562jfikDcwwBLP_j7Jzw_tymEBkx0LCFKJ-labynbhgWVq79-EE6dYikA0KLTzIEr9O_RZ_Qgqecy-l_KAlsUuyroBnFqtOFUbXTV1wksTG5dNs3pMzS8Tcn7_SXF6hOJ-bBCLbgAvHZYXwhDQG1xau8vlv-CX&csui=3&ved=2ahUKEwix5NKf3tiTAxUyHhAIHdPxMB8QgK4QegQIARAB), [CSS3](https://www.google.com/search?q=CSS3&mstk=AUtExfCr0_8YvUEkVbGNjSylq-SW9O1z6Mb4Y-dIbLCzkxCAJOEnc3TnfVlXUfJYWbx5am2bgeUvLkti79kkgt0yPC-q63Wt1TXZJjmXtaJ6iqVKXhayoT5YZXpbsV562jfikDcwwBLP_j7Jzw_tymEBkx0LCFKJ-labynbhgWVq79-EE6dYikA0KLTzIEr9O_RZ_Qgqecy-l_KAlsUuyroBnFqtOFUbXTV1wksTG5dNs3pMzS8Tcn7_SXF6hOJ-bBCLbgAvHZYXwhDQG1xau8vlv-CX&csui=3&ved=2ahUKEwix5NKf3tiTAxUyHhAIHdPxMB8QgK4QegQIARAC) и основы [JavaScript](https://www.google.com/search?q=JavaScript&mstk=AUtExfCr0_8YvUEkVbGNjSylq-SW9O1z6Mb4Y-dIbLCzkxCAJOEnc3TnfVlXUfJYWbx5am2bgeUvLkti79kkgt0yPC-q63Wt1TXZJjmXtaJ6iqVKXhayoT5YZXpbsV562jfikDcwwBLP_j7Jzw_tymEBkx0LCFKJ-labynbhgWVq79-EE6dYikA0KLTzIEr9O_RZ_Qgqecy-l_KAlsUuyroBnFqtOFUbXTV1wksTG5dNs3pMzS8Tcn7_SXF6hOJ-bBCLbgAvHZYXwhDQG1xau8vlv-CX&csui=3&ved=2ahUKEwix5NKf3tiTAxUyHhAIHdPxMB8QgK4QegQIARAD). Задания стоит ориентировать на создание адаптивных интерфейсов, работу с формами и простой интерактив, проверяя верстку, логику и стилевое  оформление (примеры проектов на [Habr](https://habr.com/ru/companies/sibirix/articles/219763/)).

Структура олимпиады (Стартовый уровень)

- **Формат:** Очный или заочный тур.
- **Время:** 2–3 часа.
- **Стек:** HTML5, CSS3 (Flexbox/Grid), JavaScript (ES6+).
- **Критерии оценки:** Правильность верстки, адаптивность (наличие `viewport`), работа функционала, читаемость кода. 

------

Примеры заданий

Задание 1: «Адаптивная визитка-резюме» (HTML+CSS)

**Цель:** Проверить навыки создания структуры страницы и стилизации.
**Задача:** Создать одностраничный сайт-резюме (на основе [описания](https://www.google.com/url?sa=i&source=web&rct=j&url=https://dep_tmomi.pnzgu.ru/news/2022/04/20/9260859/print&ved=2ahUKEwix5NKf3tiTAxUyHhAIHdPxMB8Qy_kOegQIBxAB&opi=89978449&cd&psig=AOvVaw0eCfeZ9oIMMZ6QqAapsMeu&ust=1775548100252000)).

- **Требования:**
  1. Использовать семантические теги (`<header>`, `<main>`, `<footer>`).
  2. Добавить фото, краткое описание, список навыков и форму контактов.
  3. Реализовать адаптивную верстку: на десктопе — 2 колонки, на мобильных — 1 колонка.
  4. Использовать CSS Flexbox для центрирования элементов.

Задание 2: «Интерактивный калькулятор скидок» (JS)

**Цель:** Проверить базовые навыки JavaScript.
**Задача:** Создать веб-страницу с формой ввода цены товара и процента скидки.

- **Требования:**
  1. Поле ввода «Цена» (number), ползунок (range) «Скидка» (0-100%).
  2. Кнопка «Рассчитать».
  3. При нажатии кнопка выводит итоговую цену

Результат должен отображаться динамически, без перезагрузки страницы (использование `addEventListener`).

Задание 3: «Галерея с фильтром» (CSS+JS)

**Цель:** Работа с классами CSS и манипуляция DOM-деревом.
**Задача:** Создать галерею картинок (5-6 шт.) с кнопками фильтрации по категориям (например, "Природа", "Город").

- **Требования:**
  1. При нажатии на кнопку "Природа", отображаются только соответствующие фото.
  2. Использовать CSS-свойство `display: none;` для скрытия элементов.
  3. Анимировать появление фото (transition).

------

Критерии оценки (примерные)

- **Максимум:** 30 баллов (как пример подхода [StudOlimp](https://studolimp.ru/olimp/proektirovanie-interfeysov/)).
- **Верстка:** 10 баллов (семантика, CSS).
- **Адаптивность:** 10 баллов (работа на разных разрешениях).
- **JS функционал:** 10 баллов (работает/не работает).

Ресурсы для подготовки

- **MDN Web Docs:** HTML, CSS, JS.
- **Практика:** Задачи с [T-J](https://t-j.ru/short/competitive-programming/) по алгоритмам.
- **Битрикс:** Базовые знания [Крипта](https://kripta.ru/uchebnyy-ts)
