```yml
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://loki:3100/loki/api/v1/push

# ======================================
# SCRAPE CONFIGS
# ======================================
scrape_configs:
  # ───────────── System log files (/var/log/*.log) ─────────────
  - job_name: system
    static_configs:
      - targets:
          - localhost
        labels:
          job: system
          host: ${HOSTNAME}
          __path__: /var/log/**/*.log
    pipeline_stages:
      - regex:
          expression: '^(?P<timestamp>[^ ]+)\s+(?P<level>[A-Z]+)\s+(?P<msg>.*)'
      - timestamp:
          source: timestamp
          format: RFC3339
          fallback_formats:
            - RFC3339Nano
            - Unix
      - labels:
          level:
          host:
      - output:
          source: msg

  # ───────────── Systemd journal ─────────────
  - job_name: systemd
    journal:
      max_age: 12h
      path: /var/log/journal
      labels:
        job: systemd
        host: ${HOSTNAME}
    relabel_configs:
      - source_labels: ['__journal__systemd_unit']
        target_label: 'unit'
      - source_labels: ['__journal_priority']
        target_label: 'priority'
    pipeline_stages:
      - match:
          selector: '{job="systemd"}'
          stages:
            - regex:
                expression: '^(?P<message>.*)$'
            - labels:
                priority:
                unit:
                host:
            - output:
                source: message

  # ───────────── Docker stdout/stderr ─────────────
  - job_name: docker
    static_configs:
      - targets:
          - localhost
        labels:
          job: docker
          host: ${HOSTNAME}
          __path__: /var/lib/docker/containers/*/*.log
    pipeline_stages:
      - docker: {}
      - timestamp:
          source: time
          format: RFC3339Nano
      - labels:
          stream:
          host:
      - output:
          source: log

  # ───────────── Containerd logs ─────────────
  - job_name: containerd
    static_configs:
      - targets:
          - localhost
        labels:
          job: containerd
          host: ${HOSTNAME}
          __path__: /var/log/containerd/**/*.log
    pipeline_stages:
      - regex:
          expression: '^(?P<ts>[^ ]+)\s(?P<msg>.*)'
      - timestamp:
          source: ts
          format: RFC3339Nano
          fallback_formats:
            - Unix
      - labels:
          host:
      - output:
          source: msg

  # ───────────── Custom NestJS logs ─────────────
  - job_name: nestjs
    static_configs:
      - targets:
          - localhost
        labels:
          job: nestjs
          host: ${HOSTNAME}
          __path__: /var/log/nestjs/*.log
    pipeline_stages:
      - regex:
          expression: '^(?P<timestamp>[^ ]+)\s+\[(?P<level>[A-Z]+)\]\s+(?P<msg>.*)'
      - timestamp:
          source: timestamp
          format: RFC3339
      - labels:
          level:
          host:
      - output:
          source: msg
```


```yml
promtail:
  image: grafana/promtail
  container_name: monitoring-promtail
  restart: unless-stopped
  networks:
    - proxy
  environment:
    - HOSTNAME=${HOSTNAME}
  volumes:
    - ./promtail/promtail-config.yaml:/etc/promtail/config.yaml:ro
    - /var/log:/var/log:ro
    - /var/log/journal:/var/log/journal:ro
    - /run/log/journal:/run/log/journal:ro
    - /var/lib/docker/containers:/var/lib/docker/containers:ro
  command: -config.file=/etc/promtail/config.yaml
```