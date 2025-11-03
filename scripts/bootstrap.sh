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

# ────────────── Создаём docker secrets ──────────────
echo "✅🔑 Creating Docker secrets from .env..."
while IFS='=' read -r key value; do
    [[ -z "$key" || "$key" =~ ^# ]] && continue
    if ! docker secret inspect "$key" &>/dev/null; then
        echo "$value" | docker secret create "$key" -
        echo "🗝 Secret created: $key"
    else
        echo "🔒 Secret already exists: $key"
    fi
done < .env

# ────────────── Запуск стека ──────────────
echo "✅🚀 Starting Docker Compose stack in $HOST"
docker compose -f /srv/docker/compose.yml up --build -d --project-name 'server-infra'

echo "✅✅✅🎉 All done! Stack is running."
