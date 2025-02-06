## VMs
i-04b9d8b523d279487 (clp)
PublicIPs: 52.71.111.185    PrivateIPs: 172.31.21.38    

i-08ce137d73f9f21e4 (planta)
PublicIPs: 18.215.174.216   PrivateIPs: 172.31.19.88   

i-017485dd5dc797090 (supervisorio)
PublicIPs: 98.85.204.87    PrivateIPs: 172.31.19.23    

--- 
### Guia para rodar o OpenCLP Runtime
sudo systemctl start openplc
acesse em http://52.71.111.185:8080/login
login user and password openplc

> OpenCLP Editor foi instalado diretamente no Windows
> falar sobre mudança da senha do openplc e tb das VMs como melhoria
> pra acessar o node-red colocar o ip publico da vm:1880
> falar sobre pq não acessar via loopback
> explicar função do firewall e sua relação com as configurações do grupo de segurança da AWS

> sensor como input, read only
> atuador como output read write

> o tempo de request do supervisorio deve ser igual ou maior o tempo de varredura do clp


No Modbus TCP/IP o slave id é comumente ignorado já que o endereço do dispositivo é dado por seu endereço IP
https://autonomylogic.com/docs/2-5-modbus-addressing/
---
### TAREFAS

- [X] Instalar MangoOS na VM do supervisório
- [X] Instalar OpenCLP na VM do clp
- [X] Instalar NodeRed na VM da planta
- [X] Criar projeto no OpenCLP Editor
- [] Subir projeto no OpenCLP Runtime
- [] Criar nodos no Node Red
- [] Conexão entre OpenCLP e Node Red