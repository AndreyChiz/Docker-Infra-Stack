#!/bin/bash
set -e

# ────────────── Проверка .env ──────────────
if [ ! -f .env ]; then
    echo "⚠️⚠️⚠️ .env not found, using .env.template"
    cp .env.template .env
else
    echo "✅ .env found"
fi

# ────────────── Загружаем переменные ──────────────
echo "✅ Loading environment variables..."
export $(grep -v '^#' .env | xargs)

# ────────────── Создаём profile для сервера ──────────────
echo "✅ Creating /etc/profile.d/server_env.sh..."
sudo tee /etc/profile.d/server_env.sh > /dev/null <<EOF
export HOST=${HOST}
export EMAIL=${EMAIL}
EOF

sudo chmod +x /etc/profile.d/server_env.sh
source /etc/profile.d/server_env.sh
echo "✅ HOST=${HOST}, EMAIL=${EMAIL}"

# ────────────── Запуск стека ──────────────
echo "✅🚀 Starting Docker Compose stack in $HOST"
export COMPOSE_PROJECT_NAME="server-infra"
docker compose -f /srv/docker/compose.yml up --build -d

echo "✅✅✅🎉 All done! Stack is running."
