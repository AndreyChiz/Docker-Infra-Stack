

### Переменные среды для всех пользователей 

```sh
sudo nano /etc/profile.d/chiz-work-gd-env.sh
```

```sh
#!/bin/sh

# Основной хост сервиса
export X_HOST_DOMAIN="chiz.work.gd"
```

```sh
sudo chmod +x /etc/profile.d/chiz-work-gd-env.sh
```

```sh 
docker-compose -f docker-compose.yaml -f whoami.yml up -d    
# docker-compose -f docker-compose.yaml -f whoami.yml down   
```