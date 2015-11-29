# jasmine-docker

Container Docker para executar o [JASMINE][1].

Esse container já possui toda a configuração necessária para executar e testar o
JASMINE, incluindo:

  - banco de dados no próprio container (não precisa de um container separado)
  - agente SNMP (o próprio container pode ser monitorado)
  - cron para consultar dispositivos a cada 5 minutos

## Dependências

  - [Docker][2]

## Executando

Para rodar esse container, o comando é:

    $ docker run --name jasmine -d -p 80:80 -p 161:161 eduardoweiland/jasmine-docker

Esse comando irá executar o servidor na porta 80. Para acessá-lo, o endereço é apenas:

  - **http://127.0.0.1/**


[1]: https://github.com/eduardoweiland/jasmine
[2]: https://www.docker.com
