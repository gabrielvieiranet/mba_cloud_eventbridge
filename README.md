# MBA - CLOUD - EVENTBRIDGE

Trabalho final da disciplina de Cloud Engineering ministrada pelo Rafael Barbosa:

https://github.com/vamperst/fiap-cloud-computing-tutorials/blob/master/Trabalho-Final/README.md

O professor sugeriu utilizarmos Serverless para facilitar a parte de infra mas optamos por fazer com Terraform.

Configuração de ambiente:

1. Configurar o ambiente para acessar a conta AWS pelo console
2. Entrar no diretório infra e subir a infra Terraform (```terraform apply```)
3. Entrar em apps e executar ```python putEventsPizzaria.py``` para enviar eventos para o EventBridge