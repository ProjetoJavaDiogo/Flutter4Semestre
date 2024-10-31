Apresentação do Projeto
O projeto visa desenvolver um Sistema de Controle de Acesso e Gerenciamento de Visitas para Condomínios. Com a crescente preocupação em segurança, organização e facilidade de gestão em ambientes residenciais e empresariais, o sistema propõe um controle de entrada e saída que integra autenticação segura (via reconhecimento facial e QRCode) e funcionalidades personalizáveis para proprietários, moradores, prestadores de serviço e administração do condomínio.

A solução almeja facilitar o cadastro e monitoramento de acessos, simplificar a autorização de visitas, e oferecer uma visão detalhada do fluxo de pessoas no condomínio. Para os administradores, serão disponibilizados relatórios de uso, notificações em tempo real e controle restrito de áreas.

Discussão Inicial de Requisitos
Abaixo estão os requisitos iniciais, divididos por funcionalidades essenciais e funcionalidades adicionais sugeridas:

1. Cadastro de Proprietários e Moradores
Dados pessoais: nome, CPF, endereço, telefone.
Cadastro de moradores: reconhecimento facial, nome, CPF, endereço, telefone.
Cadastro de veículos: marca, modelo, placa, tag NFC.
2. Gestão de Acesso e Convites de Visita
Convite de Visita: O proprietário pode convidar prestadores e definir período de visita.
Geração de QRCode para acesso temporário.
Aprovação de Visita: Proprietário pode aprovar ou recusar solicitações enviadas por prestadores.
3. Gestão de Prestadores de Serviço
Cadastro: dados pessoais, reconhecimento facial, empresa.
Aceitação de Convite: prestadores podem aceitar ou recusar convites.
Solicitação de Visita: definição do motivo e período para visita.
4. Funções para Administração do Condomínio
Cadastro e edição de moradores e visitantes.
Aprovação de cadastros de moradores.
Controle de Funções e Acesso: liberação e restrição de áreas para funcionários, moradores e visitantes.
Envio de notificações para moradores e visitantes.
Restrição de acesso forçado, mesmo que um morador tenha liberado.
5. Funcionalidades de Segurança e Auditoria
Histórico de acessos para proprietários, visitantes e prestadores.
Notificações em tempo real para atividades suspeitas ou tentativas de acesso fora do período autorizado.
Integração com sistema de segurança: como câmeras e alarmes para monitoramento contínuo.
6. Funcionalidades Adicionais Sugeridas
Painel de Relatórios: análise de dados como frequência de visitas, áreas mais acessadas, e histórico de restrições.
Check-in/Check-out digital: para facilitar o registro de tempo dos prestadores de serviço.
Controle de Permissões Avançado: com autorização de áreas específicas para determinados moradores ou visitantes.

flowchart TD
    %% Cadastro de Proprietário
    A[Inicio] --> B[Cadastro do Proprietário]
    B --> B1{Dados do Proprietário}
    B1 --> B2[Nome, CPF, Endereço, Telefone]
    B2 --> B3[Cadastro Moradores e Veículos]

    %% Cadastro de Moradores
    B3 --> C1[Cadastro de Morador]
    C1 --> C2[Reconhecimento Facial, Nome, CPF, Endereço, Telefone]
    C2 --> C3[Cadastro de Veículos]
    C3 --> C4[Marca, Modelo, Placa, Tag NFC]

    %% Convidar Prestador
    B3 --> D[Convidar Prestador]
    D --> D1[Definir Período de Visita]
    D1 --> D2[Gerar QRCode]
    D2 --> D3[Gerar Liberação no Condomínio]

    %% Solicitação de Visita - Prestador
    D3 --> E[Prestador Solicita Visita]
    E --> E1{Preenchimento dos Dados}
    E1 --> E2[Motivo da Visita]
    E2 --> E3[Definir Período da Visita]

    %% Aprovação da Visita - Proprietário
    E3 --> F[Aprovar Solicitação de Visita]
    F --> F1{Proprietário Aprova?}
    F1 -->|Sim| F2[Gerar QRCode e Liberação]
    F1 -->|Não| F3[Recusar Solicitação]

    %% Controle pelo Condomínio
    A --> G[Administração do Condomínio]
    G --> G1{Funções para o Administrador}
    G1 --> G2[Cadastro/Edição de Morador]
    G2 --> G3[Aprovação de Cadastro de Morador]
    G3 --> G4[Cadastro/Edição de Visitante]
    G4 --> G5[Controle de Funções e Acesso]
    G5 --> G6[Liberar ou Restringir Áreas]
    G6 --> G7[Envio de Mensagem para Morador/Visitante]
    G7 --> G8[Restrição de Acesso Forçado]

    %% Notificações e Histórico de Acessos
    F2 --> H[Notificações]
    H --> H1[Enviar Notificação para Proprietário/Morador]
    H --> H2[Enviar Notificação para Prestador]
    H --> H3[Histórico de Acessos]

    %% Finalização
    F3 --> I[Fim]
    H3 --> I
    G8 --> I
