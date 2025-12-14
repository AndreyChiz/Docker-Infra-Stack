#### Пример запроса

```sh
  curl https://ai.chiz.work.gd/api/chat \
  -H "Content-Type: application/json" \
  -d '{
    "model": "qwen3-vl:2b-instruct",
    "messages": [
      { "role": "system", "content": "ты всегда отвечаешь по русски максимально коротко" },
      { "role": "user", "content": "какая модель отвечает" }
    ],
    "stream": true,
    "temperature": 0.2,
    "top_p": 0.85,
    "top_k": 30,
    "repeat_penalty": 1.1,
    "num_thread": 7
  }'
```


#### Проверенные модели

-/+  работает / не работатет
```md
qwen3-vl:4b -
deepseek-r1:1.5b + (валенок)
llama3.2:3b ++
ollama run qwen3:4b ???
qwen3-vl:2b  ++
qwen3-vl:2b-instruct ++++
```

# Docker

```sh
docker run -d -v ollama:/root/.ollama -p 11434:11434 --name ollama ollama/ollama

docker exec -it ollama ollama run qwen3-vl:2b-instruct 
```


#### Пример настройки

```sh
sudo sysctl -w vm.overcommit_memory=1   
sudo sysctl -w vm.swappiness=120 
echo never | sudo tee /sys/kernel/mm/transparent_hugepage/enabled

docker run -d --name ollama \
  -p 11434:11434 \
  -v ollama:/root/.ollama \
  --memory=2500m \
  --memory-swap=5g \
  --ulimit memlock=-1:-1 \
  ollama/ollama

  docker exec -it ollama ollama run qwen3-vl:2b-instruct
```
