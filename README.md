# What is this

A simple server stack with metrics, logs, traces, a database, a private Docker registry, and Traefik.

# Quick Start

## Pre-Installation

- You need to have Docker and Docker Compose installed (use the [Docker docs](https://docs.docker.com/) for guidance) before installing.
- You need to have a public DNS (`<YOUR_DNS>` like `vasya_pupkin.ru`, for example).
- You need to have the following AAA records:
  - `reg.<YOUR_DNS>`
  - `grafana.<YOUR_DNS>`
  - `traefik.<YOUR_DNS>`
  - `jenkins.<YOUR_DNS>`

😎 *Or set `<YOUR_DNS>` to "localhost" and use everything locally without DNS and AAA records.* 😎

## Installation

1. Set the environment variables:

```sh
sudo tee /etc/profile.d/server_env.sh > /dev/null <<'EOF'
export HOST=<YOUR_DNS>
export EMAIL=<YOUR_EMAIL>

# Example
# export HOST=chiz.work.gd
# export EMAIL=andrey.chizhov.dev@gmail.com
EOF

sudo chmod +x /etc/profile.d/server_env.sh
source /etc/profile.d/server_env.sh
printenv HOST EMAIL
```


2. Install the stack

```sh
sudo mkdir /srv/docker
sudo chown $USER:$USER -R /srv/docker
# git clone  git@github.com:AndreyChiz/Docker-Infra-Stack.git /srv/docker
git clone --branch feature/vault_passwd --single-branch --depth 1 git@github.com:AndreyChiz/Docker-Infra-Stack.git /srv/docker
/srv/docker/scripts/bootstrap.sh
```

## A few moment later...

### You can use the

#### Awalible resources

-   docker_registry
    https://reg.<YOUR_DNS>/ui - ui
    https://reg.<YOUR_DNS>t/v2/ - api
-   grafana
    https://grafana.<YOUR_DNS>/grafana
-   traefik
    https://traefik.<YOUR_DNS>/dashboard/
-   jenkins
    https://jenkins.<YOUR_DNS>

    *_all metrics, traces, logs will bee awalible in grafana_*
