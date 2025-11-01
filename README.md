/etc/docker/daemon.json

```json
{
    "registry-mirrors": [
        "https://mirror.gcr.io",
        "https://dockerhub.timeweb.cloud",
        "https://registry.docker-cn.com"
    ],
    "insecure-registries": ["reg.localhost"]
}
```

```sh
sudo systemctl restart docker
```

```sh
sudo mkdir /srv/docker
chown $USER:$USER -R /srv/docker
git clone -b dev git@github.com:AndreyChiz/Docker-Infra-Stack.git /srv/docker
./scripts/run.dev.sh
```
