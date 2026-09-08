# Unbox ASMR Tycoon

Мобильная PWA-игра в вертикальной ориентации: исследование зон, распаковка посылок, ASMR-награды, события, коллекции, сезонный прогресс и косметические предметы.

## Структура

- `index.html` — оболочка приложения, экраны Home/Game/Panel и мобильная навигация.
- `styles.css` — адаптивная тема, карточки, HUD, анимации и эффекты интерфейса.
- `app.js` — игровой цикл, карта Canvas, управление, распаковка, экономика, магазин, каталоги, события и сохранение.
- `manifest.webmanifest` — PWA manifest с portrait-режимом и иконками.
- `sw.js` — Service Worker и офлайн-кэш.
- `icon-192.svg`, `icon-512.svg` — иконки приложения.

## Локальный запуск

Для Service Worker нужен HTTP(S), а не `file://`:

```bash
python -m http.server 8080
```

Откройте `http://localhost:8080`.

## Деплой на VPS

1. Установите Nginx и Certbot.
2. Скопируйте содержимое проекта в `/var/www/unbox-asmr`.
3. Настройте Nginx на `root /var/www/unbox-asmr;` и отдачу `index.html` для SPA-маршрутов.
4. Включите HTTPS через Certbot. PWA installability требует HTTPS.
5. Убедитесь, что `.webmanifest` отдаётся с `application/manifest+json`, а `sw.js` — с `application/javascript`.
6. Проверьте в DevTools: Manifest, Service Worker, Cache Storage и Lighthouse PWA.

Пример:

```bash
sudo rsync -a ./ /var/www/unbox-asmr/
sudo nginx -t && sudo systemctl reload nginx
sudo certbot --nginx -d example.com
```

## Сборка для RuStore

PWA сама по себе публикуется как веб-приложение; для RuStore нужен Android-пакет-обёртка (например, Trusted Web Activity/Bubblewrap или PWABuilder). Пакет собирается после размещения игры на HTTPS-домене и проверки manifest/service worker. Подпишите APK/AAB своим ключом и загрузите его в RuStore вместе с политикой конфиденциальности, описанием покупок и скриншотами.

## Что нужно добавить перед production

- серверный аккаунт и синхронизацию прогресса;
- реальный Telegram Bot API backend и подтверждение платежей на сервере;
- лицензированные аудиофайлы и CDN для тяжёлых ассетов;
- backend-таблицу лидеров и защиту экономики;
- полноценные 3D-ассеты, атласы текстур и авторские звуки.
