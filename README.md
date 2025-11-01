/etc/docker/daemon.json

## Quick start

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

1. Change localhost for you dns name change HOST=localhost to host=<YOUR_HOST_DNS>
2. Do **"Install in dev workspace"**
3. change in jenkinsfile env.HOST="chiz.work.gd" to env.HOST="<YOUR_HOST_DNS>"
4. Create job in jenkins ui and set git trigger like in standart flow

```sh
sudo mkdir /srv/docker
sudo chown $USER:$USER -R /srv/docker
git clone  git@github.com:AndreyChiz/Docker-Infra-Stack.git /srv/docker
/srv/docker/scripts/run.sh
```
