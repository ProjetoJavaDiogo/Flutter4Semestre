# Sistema de Controle de Acesso e Gerenciamento de Visitas para Condomínios

O projeto visa desenvolver um **Sistema de Controle de Acesso e Gerenciamento de Visitas** para condomínios, focando na segurança, organização e facilidade de gestão de entradas e saídas. O sistema integra autenticação segura, utilizando reconhecimento facial e QRCode, e oferece funcionalidades personalizáveis para diferentes usuários: proprietários, moradores, prestadores de serviço e administradores.

![Logo do Projeto](./portaria_condominio//assets/images/logopng)

## Sumário

1. [Objetivos](#objetivos)
2. [Requisitos Iniciais](#requisitos-iniciais)
   - [Funcionalidades Essenciais](#funcionalidades-essenciais)
   - [Funcionalidades Adicionais Sugeridas](#funcionalidades-adicionais-sugeridas)
3. [Fluxo de Cadastro e Acesso](#fluxo-de-cadastro-e-acesso)
4. [Tecnologias Utilizadas](#tecnologias-utilizadas)
5. [Contribuindo](#contribuindo)

---

## Objetivos

- **Facilitar o cadastro e monitoramento de acessos.**
- **Simplificar a autorização de visitas** por meio de QRCode e reconhecimento facial.
- **Prover uma visão detalhada do fluxo de pessoas** no condomínio.
- **Gerar relatórios de uso**, notificações em tempo real e controle restrito de áreas para administradores.

---

## Requisitos Iniciais

### Funcionalidades Essenciais

1. **Cadastro de Proprietários e Moradores**
   - Dados pessoais: nome, CPF, endereço, telefone.
   - Cadastro de moradores com reconhecimento facial.
   - Cadastro de veículos (marca, modelo, placa, tag NFC).

2. **Gestão de Acesso e Convites de Visita**
   - Proprietário pode convidar prestadores e definir período de visita.
   - Geração de QRCode para acesso temporário.
   - Aprovação ou recusa de visitas pelo proprietário.

3. **Gestão de Prestadores de Serviço**
   - Cadastro de prestadores: dados pessoais, reconhecimento facial, empresa.
   - Aceitação de convite para visita.
   - Definição do motivo e período da visita.

4. **Funções para Administração do Condomínio**
   - Cadastro e edição de moradores e visitantes.
   - Aprovação de cadastros de moradores.
   - Controle de acesso a áreas e envio de notificações.
   - Restrição de acesso forçado, mesmo se autorizado por moradores.

5. **Funcionalidades de Segurança e Auditoria**
   - Histórico de acessos de moradores, visitantes e prestadores.
   - Notificações em tempo real sobre atividades suspeitas.
   - Integração com sistema de segurança (câmeras, alarmes).

### Funcionalidades Adicionais Sugeridas

- **Painel de Relatórios:** Análise de dados sobre frequência de visitas e áreas mais acessadas.
- **Check-in/Check-out digital** para prestadores de serviço.
- **Controle de Permissões Avançado:** Autorização de áreas específicas para moradores e visitantes.

---

## Fluxo de Cadastro e Acesso

```mermaid
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
```