# Implementação de integração por Modbus TCP/IP, em Prova de Conceito, de sistema supervisão, controle e planta virtual

*Trabalho Prático II da disciplina de Redes para Controle e Automação [2024/2], ministrada pelo professor [Rafael Emerick Zape de Oliveira](https://github.com/rafaelrezo).*
**O presente trabalho é de autoria intregal da aluna [Sofia de Alcantara](https://github.com/sofialctv)**.

![alt text](<./img/Industrial Networking Automation.avif>)

# Introdução
O objetivo desse trabalho se dá por implementar a integração de três diferentes plataformas (sistema supervisório, sistema de controle e a planta virtual), visando a disponibilização de um ambiente de testes para supervisão Modbus TCP/IP.

> 📃 As orientações completas de execução da atividade podem ser lidas no arquivo [especificacao.pdf](especificacao.pdf).

# Contextualização
Para melhor entendimento dos resultados obtidos nesse trabalho, é de extrema importância a contextualização de conceitos presentes durante toda a execução da tarefa. Isso posto, vamos começar entendendo melhor do que se trata o protocolo **ModbusTCP/IP**.

## Modbus TCP/IP

Em ambientes industriais, é comum existir uma variedade de dispositivos, como CLPs (Controladores Lógicos Programáveis), sensores, atuadores e sistemas supervisórios, que precisam se comunicar entre si para garantir o funcionamento correto e integrado de processos complexos. 

Um dos recursos para estabelecimento da comunicação entre dispositivos é o protocolo **Modbus TCP/IP** desenvolvido na década de 1970 pela Modicon e se constituindo como um dos protocolos de comunicação mais amplamente utilizados em sistemas de automação industrial.

Baseado no **padrão Ethernet** e no **protocolo TCP/IP**, o **Modbus TCP/IP** dispõe da simplicidade e robustez (mantendo a estrutura da mensagem, comunicação baseada em registro, etc.) do protocolo Modbus original, adicionando confiabilidade e interoperabilidade do TCP/IP. Ele encapsula os dados Modbus tradicionais em um pacote TCP/IP, permitindo que os dados sejam transportados por infraestruturas de rede padrão. 

Recomendo a leitura do artigo **"[Understanding Modbus TCP-IP: An In depth Exploration](https://www.wevolver.com/article/modbus-tcp-ip#modbus-tcp/ip:-basic-concepts-and-principles)"** caso deseje se aprofundar quanto ao protocolo.

## Dispostivos Industriais

Como citados anteriormente, os sistemas de automação industrial dependem de uma variedade de dispositivos que trabalham em conjunto para controlar e monitorar processos complexos.

Entre esses dispositivos, destacam-se os **CLPs (Controladores Lógicos Programáveis)**, os **sistemas supervisórios** e as **plantas industriais**. Cada um desempenha um papel crucial na automação, e entender suas funções auxiliará na compreensão geral do trabalho.

### CLPs (Controladores Lógicos Programáveis)
Os CLPs são dispositivos eletrônicos programáveis projetados para controlar máquinas e processos industriais. Por meio de uma linguagem de programação, como **Ladder** os CLPs executam lógicas de controle que determinam como os equipamentos devem operar. 

O CLP utilizado no contexto do trabalho será configurado utilizando a solução open source **[OpenPLC](https://github.com/thiagoralves/OpenPLC_v3)**.

### Sistemas Supervisórios
Os sistemas supervisórios são softwares que permitem monitorar e controlar processos industriais de forma centralizada, coletando dados dos CLPs e outros dispositivos e exibindo-os em uma interface gráfica amigável (IHM - Interface Homem-Máquina).

O sistema supervisório escolhido para instalação foi o **[Mango-OS](https://radixiot.com/mango-os)**.

### Plantas Industriais
Por fim, as plantas industriais representam o ambiente físico onde os processos industriais ocorrem. Compostas por máquinas, equipamentos, sensores e atuadores que interagem entre si para realizar tarefas específicas.

Em um ambiente de automação, a planta é controlada pelos CLPs e monitorada pelo sistema supervisório. Juntos, esses dispositivos formam a base dos sistemas de automação industrial, permitindo que processos complexos sejam executados de forma eficiente, segura e confiável.

Para a configuração da nossa planta virtual utilizaremos o **[Node Red](https://nodered.org/)**.

# Infraestrutura e Configuração
Feita a contextualização inicial e apresentação dos conceitos recorrentes ao trabalho, seguimos para explanação da infraestrutura escolhida.

## Máquinas Virtuais

Foram criadas três instâncias (representando o sistema supervisório, sistema de controle e a planta virtua) EC2 utilizando a infraestrutura da AWS Academy.

Para garantir a segurança e o funcionamento adequado dessas máquinas virtuais, foi essencial configurar corretamente os **grupos de segurança** na AWS, que atuam como um *firewall* virtual, controlando o tráfego de rede para as instâncias EC2.

### Firewall e Grupos de Segurança na AWS
Um **firewall** é um dispositivo de segurança que monitora o tráfego de rede de entrada e saída e decide permitir ou bloquear tráfegos específicos de acordo com um conjunto definido de regras de segurança. Na AWS, essa funcionalidade é implementada por meio dos grupos de segurança, que atuam como firewalls virtuais para as instâncias EC2.

### IPs Dinâmicos e Estáticos
Outro detalhe importante é que na AWS, a configuração padrão para instâncias EC2 utiliza **IPs dinâmicos**, o que significa que o endereço IP associado a uma instância pode mudar sempre que essa é reiniciada ou interrompida. 

No contexto deste projeto, a utilização de IPs dinâmicos poderia causar falhas de comunicação sempre que os endereços IP das instâncias mudassem, interrompendo o funcionamento dos sistemas e exigindo reconfigurações manuais frequentes.

Por isso, foram configurados **IPs estáticos** (também conhecidos como Elastic IPs na AWS) para cada uma das instâncias EC2. Um Elastic IP é um endereço IP público *fixo* que garante que o endereço IP não mude mesmo após reinicializações ou interrupções das VMs.

![alt text](./img/endereços-ip-instancias.png)

# OpenPLC: CLP Virtual
Fazendo uso do OpenPLC Editor, foi implementada em **ladder** uma planta industrial simulada (veja o projeto no diretório [openplc-editor](./openplc-editor/)).

![alt text](/img/planta-ladder.png)

O detalhe mais importante a ser observado é o campo `Localização`, que é fundamental para definir o endereçamento das variáveis utilizadas no programa ladder. Esse campo especifica onde a variável está localizada na memória do PLC, e o endereçamento segue o padrão Modbus.

## Endereçamento Modbus
O protocolo Modbus utiliza um esquema de endereçamento que permite acessar diferentes tipos de registros, entre eles:

- **Coils (Discretas de Saída)**, que são usados para variáveis booleanas de saída.
- **Discrete Inputs (Entradas Discretas)**, que são usados para variáveis booleanas de entrada.
- **Holding Registers (Registradores de Manutenção)**, que são usados para variáveis do tipo inteiro (16 bits) ou float (32 bits).
- **Input Registers (Registradores de Entrada)**, que são usados para variáveis de entrada do tipo inteiro ou float.

Com apoio da [tabela de endereçamento Modbus](https://autonomylogic.com/docs/2-5-modbus-addressing/), o campo `Localização` foi preenchido para mapear variáveis remotas que serão utilizadas no sistema supervisório para interação.

# Node Red - Planta Virtual



```
## Implementação do Sistema Supervisório
- **Instalação e Configuração**: Passos para instalar e configurar o sistema supervisório escolhido.
  
- **Interface Homem-Máquina (IHM)**: Descrição da IHM desenvolvida, incluindo botões de comando e visualização de variáveis de processo.


## Simulação da Planta Virtual no Node-RED
- **Nodos**: Descrição dos nodos implementados no Node-RED (atuador, sensor, planta).
- **Simulação de Processos**: Explicação de como as variáveis de processo são simuladas e integradas ao sistema.

## Testes e Validação
- **Testes de Comunicação**: Descrição dos testes realizados para validar a comunicação Modbus TCP/IP entre as máquinas virtuais.
- **Resultados**: Apresentação dos resultados obtidos, incluindo capturas de tela da IHM e logs de comunicação.

### Conclusão
- **Aprendizados**: Reflexões sobre o que foi aprendido durante a implementação do projeto.

- **Melhorias Futuras**: Sugestões para melhorias e expansões futuras do ambiente de testes.
```


### Referências
1. https://www.wevolver.com/article/modbus-tcp-ip#modbus-tcp/ip:-basic-concepts-and-principles
2. https://www.sin.ufscar.br/servicos/conectividade/firewall/o-que-e-um-firewall
3. https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html