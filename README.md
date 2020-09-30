# Script para teste de carga em docker

## Utilização

Dentro da pasta **Teste**, coloque o arquivo *.jmx* — e o csv, caso o teste precise. Na estrutura como mostrado abaixo:

```
+ Teste
└─ TesteApiPortal.jmx
└─ Usuarios.csv
- docker-compose.yml
- DockerFile
- execute.bat
```

Cada *slave* executa o número de trheads configurados no arquivo *.jmx*. Para definir a quantidade de slaves à serem criados, mude no arquivo "docker-compose.yml" a propriedade "replicas"

```yml
version: '3'
services:
  slave:
    ...
    deploy:
      replicas: 5 
```

Para iniciar o teste execute a bat "*execute.bat*"
```bash
./execute.bat
```

Aguarde o término do teste e verifique o resultado na pasta **results**.
