# Implementação de integração por Modbus TCP/IP, em Prova de Conceito, de sistema supervisão, controle e planta virtual

*Trabalho Prático II da disciplina de Redes para Controle e Automação [2024/2], ministrada pelo professor [Rafael Emerick Zape de Oliveira](https://github.com/rafaelrezo).*
**O presente trabalho é de autoria intregal da aluna [Sofia de Alcantara](https://github.com/sofialctv)**.

![Ilustração.](/img/capa.avif)

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

# OpenPLC: CLP Virtual
Fazendo uso do OpenPLC Editor, foi implementada em **ladder** uma planta industrial simulada (veja o projeto no diretório [openplc-editor](./openplc-editor/)).

![Planta ladder feita via OpenPLC Editor.](/img/planta-ladder.png)
*Figura 1: Planta ladder feita via OpenPLC Editor.*

O detalhe mais importante a ser observado é o campo `Localização`, que é fundamental para definir o endereçamento das variáveis utilizadas no programa ladder. Esse campo especifica onde a variável está localizada na memória do PLC, e o endereçamento segue o padrão Modbus.

## Endereçamento Modbus
O protocolo Modbus utiliza um esquema de endereçamento que permite acessar diferentes tipos de registros, entre eles:

- **Coils (Discretas de Saída)**, que são usados para variáveis booleanas de saída.
- **Discrete Inputs (Entradas Discretas)**, que são usados para variáveis booleanas de entrada.
- **Holding Registers (Registradores de Manutenção)**, que são usados para variáveis do tipo inteiro (16 bits) ou float (32 bits).
- **Input Registers (Registradores de Entrada)**, que são usados para variáveis de entrada do tipo inteiro ou float.

Com apoio da [tabela de endereçamento Modbus](https://autonomylogic.com/docs/2-5-modbus-addressing/), o campo `Localização` foi preenchido para mapear variáveis remotas que serão utilizadas no sistema supervisório para interação.

## OpenPLC Runtime
Configurada a planta e gerado o arquivo `.st` da mesma ([planta-ladder.st](/openplc-runtime/planta-ladder.st)), configuramos o script PSM.

### PSM: Python SoftPLC Module
A PSM é uma biblioteca Python usada para simular ou controlar um SoftPLC (um PLC implementado em software), que permite que você interaja com variáveis de um sistema de controle, como entradas e saídas digitais/analógicas, memórias, etc., de forma programática. Veja o script desenvolvido em [psm.py](/openplc-runtime/psm.py).

# Node Red: Planta Virtual
Partindo agora para o Node-RED, o [fluxo](/node-red/flows.json) simula um sistema de controle de processos, no qual há comunicação entre um atuador, uma planta (processo controlado) e um sensor, utilizando a infraestrutura de comunicação TCP para enviar e receber dados. 

![ Fluxo no Node-RED.](/img/flow.png)
*Figura 2: Fluxo no Node-RED.*

A simulação utiliza comunicação TCP em dois pontos:
- **Entrada (TCP 1515)**: Recebe o erro ou valor de controle externo.
- **Saída (TCP 1516)**: Envia a variável de processo (PV) medida de volta para outros sistemas ou supervisores.

# MangoOS: Supervisório

No sistema supervisório, foi configurada uma fonte de dados (**data source**) utilizando o PLC como host, e o **endereço IP privado** do PLC foi especificado para estabelecer a conexão. O uso de um IP privado é possível porque as máquinas que hospedam o MangoOS e o OpenPLC estão na **mesma rede local**, na AWS.

![Painel mostrando os data points configurados no MangoOS, com base nas variáveis remotas do PLC virtual.](img/mango-data-points.png)
*Figura 3: Painel mostrando os data points configurados no MangoOS, com base nas variáveis remotas do PLC virtual.*

Após a conexão com o PLC ser estabelecida, o próximo passo foi configurar os **data points** no MangoOS. Para isso, foi necessário associar as posições das variáveis no programa ladder do PLC aos respectivos **register ranges** e **offsets** no supervisório, garantindo que as variáveis do PLC virtual fossem corretamente monitoradas e controladas pelo MangoOS.

# Resultados

O sistema integrado foi capaz de executar o controle e supervisão do processo industrial simulado de maneira eficaz. A planta virtual, desenvolvida no **Node-RED**, recebeu comandos do controlador implementado no **OpenPLC** e enviou de volta os dados de processo monitorados pelo **MangoOS**.

![alt text](img/running.gif)
*GIF demonstrando funcionamento dos sistemas integrados.*

No GIF acima, observamos a interação entre as três plataformas:

1. **Node-RED**: Visualizamos o fluxo do processo de controle, onde o atuador ajusta a planta com base no valor de controle (CV) e a planta responde, retornando a variável de processo (PV) medida pelo sensor. Esse feedback é enviado para o sistema supervisório para ser monitorado.

2. **OpenPLC**: Na aba de monitoramento do **OpenPLC Runtime**, é possível observar os valores atualizados de parâmetros como Setpoint (SP), Processo (PV) e Controle (CV), juntamente com a visualização do comportamento dinâmico do sistema, conforme os valores de controle são ajustados.

3. **MangoOS**: No sistema supervisório, temos uma visualização gráfica do nível da planta simulada, representando visualmente a variável de processo (PV). O gráfico à direita da tela mostra a resposta temporal da planta, permitindo o acompanhamento em tempo real das mudanças no sistema.


# Conclusão
O trabalho desenvolvido demonstra a eficácia da combinação de diferentes ferramentas de automação para simular um ambiente de controle industrial, permitindo realizar testes e análises em tempo real. O uso do protocolo **Modbus TCP/IP** foi essencial para a comunicação fluida entre as plataformas, possibilitando uma supervisão e controle remotos de uma planta industrial virtual.

## Melhorias

Apesar do sucesso na execução do sistema, algumas melhorias podem ser implementadas para aumentar a robustez e eficiência da solução, entre elas estão:

- **Aprimoramento da Segurança com Firewall e Grupos de Segurança,** permitindo tráfego desnecessário de portas que não estão sendo utilizadas. O ideal seria restringir as portas de comunicação apenas às essenciais, como as portas TCP/IP do **Modbus** e aquelas necessárias para a interface de supervisão e controle remoto. 

- **Configuração de DNS Personalizado para o Sistema Supervisório,** facilitando o acesso ao MangoOS por meio de um domínio amigável, como `supervisorio.empresa.com`. Além disso, a criação de certificados SSL também poderia ser feita visando aumentar ainda mais a segurança das conexões.

- **Implementação de Logs de Eventos e Auditoria,** permitindo o rastreamento e armazenamento das atividades do sistema, como comandos executados e alterações de parâmetros, facilitando a identificação de problemas e a realização de auditorias de segurança e operacionais.

### Referências
1. https://www.wevolver.com/article/modbus-tcp-ip#modbus-tcp/ip:-basic-concepts-and-principles
2. https://www.sin.ufscar.br/servicos/conectividade/firewall/o-que-e-um-firewall
3. https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html