Simply server stack with metriks, logs, traces, database, private_docker_registry and dynamic server Traefik

## Quick start

### Pre-Install

You need to hawe the installed docker with docker compose (use docker docs) before installing.

### Install in dev workspace

For install infra in test/stage/dev/local workspace use this command
the all parts of system wil bee awalible in licalhost

```sh
sudo mkdir /srv/docker
chown $USER:$USER -R /srv/docker
git clone -b dev git@github.com:AndreyChiz/Docker-Infra-Stack.git /srv/docker
./scripts/pipeline_run_dev
```

#### List of awalible resources

-   docker_registry
    https://reg.localhost/ui - ui
    https://reg.localhost/v2/ - api
-   grafana
    https://grafana.localhost/grafana
-   traefik
    https://traefik/dashboard/
-   jenkins
    https://jenkins.localhost
    _all metrics, traces, logs will bee awalible in grafana_

### Use in CICD

for use without CICD:

1. set the varible in /scripts/run.sh --> export HOST="<YOUR_HOST_DNS>"
2. set the varible in /Jenkinsfile --> env.HOST="<YOUR_HOST_DNS>"
3. RUN: 
```sh
sudo mkdir /srv/docker
sudo chown $USER:$USER -R /srv/docker
git clone  git@github.com:AndreyChiz/Docker-Infra-Stack.git /srv/docker
/srv/docker/scripts/run.sh
```
4. Create job in jenkins ui and set git trigger like in standart flow

###
```sh
sudo tee /etc/profile.d/server_env.sh > /dev/null <<'EOF'
export HOST=chiz.work.gd
export DOMAIN=work.gd
export EMAIL=andrey.chizhov.dev@gmail.com
EOF

sudo chmod +x /etc/profile.d/server_env.sh
source /etc/profile.d/server_env.sh
printenv HOST DOMAIN EMAIL

```