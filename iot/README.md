# почему то emqx через docker-compose пытается спуллить образ по ipv6,
# естесственно падает
# исправляется 

```sh
sudo nano /etc/docker/daemon.json    
```

```json
{
    "dns": [
        "8.8.8.8"
    ],
    "registry-mirrors": [
        "https://mirror.gcr.io",
        "https://dockerhub.timeweb.cloud",
        "https://registry.docker-cn.com"
    ],
    "ipv6": false
}
```
