#!/bin/bash

# Render автоматически задает переменную $PORT (обычно 10000). 
# Если её нет, ставим фолбэк на 8080.
LISTEN_PORT=${PORT:-8080}

# Проверяем, задан ли UUID
if[ -z "$UUID" ]; then
  echo "Error: Переменная среды UUID не задана! Пожалуйста, добавьте ее в настройках Render."
  exit 1
fi

# Подставляем порт и UUID в config.json
sed -i "s/PORT_PLACEHOLDER/$LISTEN_PORT/g" /etc/xray/config.json
sed -i "s/UUID_PLACEHOLDER/$UUID/g" /etc/xray/config.json

echo "Конфигурация успешно обновлена. Запуск Xray на порту $LISTEN_PORT..."

# Запускаем Xray через exec, чтобы он стал PID 1 и корректно обрабатывал системные сигналы (SIGTERM)
exec /usr/local/bin/xray run -config /etc/xray/config.json