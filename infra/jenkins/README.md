



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

3. Проверка docker

```sh
docker -v
docker buildx ls
```