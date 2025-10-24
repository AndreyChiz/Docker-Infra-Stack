### Настройка Docker
Для доступа к хостовому docker docker-compose установить в контейнере клиенты

```sh
apt-get update && apt-get install -y ca-certificates curl gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
    > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli docker-compose-plugin && \
    rm -rf /var/lib/apt/lists/*

# Данная команда указана в создаии образа, не проверялось. (устанавливал в ручную)

```



### Авторизация GitHub
1.
```sh
ssh-keygen
# Generating public/private ed25519 key pair.
# Enter file in which to save the key (/root/.ssh/id_ed25519): jenkins
# Enter passphrase for "jenkins" (empty for no passphrase): 
# Enter same passphrase again: 
# Your identification has been saved in jenkins
# Your public key has been saved in jenkins.pub
```

2. Чтобы ключ заработал для Gihub в контейнере нужно добавить 
```sh

mkdir -p ~/.ssh
ssh-keyscan github.com >> ~/.ssh/known_hosts
chmod 644 ~/.ssh/known_hosts
```