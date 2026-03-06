# Используем минималистичный образ Alpine Linux
FROM alpine:latest

# Устанавливаем необходимые утилиты
RUN apk add --no-cache curl unzip bash sed

# Создаем директории для Xray
RUN mkdir -p /usr/local/bin /etc/xray

# Скачиваем последнюю версию Xray-core (linux-64) и распаковываем
RUN curl -L -H "Cache-Control: no-cache" -o xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip xray.zip -d /tmp/xray && \
    mv /tmp/xray/xray /usr/local/bin/xray && \
    chmod +x /usr/local/bin/xray && \
    rm -rf xray.zip /tmp/xray

# Копируем конфигурацию и скрипт запуска
COPY config.json /etc/xray/config.json
COPY start.sh /start.sh

# Делаем скрипт исполняемым
RUN chmod +x /start.sh

# Запускаем скрипт (точка входа)

CMD["/start.sh"]
