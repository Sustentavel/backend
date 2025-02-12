# README

## Setup do backend

```bash
  ./bin/docker_setup.sh
```

## Após realizar o setup do backend, rode o comando abaixo para subir a aplicação
```bash
  docker-compose up
```

## Para acessar o bash, utilize o comando abaixo
```bash
  docker-compose run --rm sst bash
```

## Você pode utilizar comandos de verificação da integridade do código, como por exemplo
```bash
  rspec # Roda todos os testes
  rubocop # Verifica se o código está formatado corretamente
  rails c # Acessar o terminal do rails, podendo realizar queries
```
