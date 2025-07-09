# GIC - Gerenciador Inteligente de Clientes

**Versão:** 0.0.0
**Data:** 08 de Julho de 2025

## 1. Descrição

O GIC (Gerenciador Inteligente de Clientes) é um aplicativo móvel desenvolvido em Flutter, projetado para oferecer uma solução simples e eficiente para o gerenciamento de clientes. O projeto serve como um exemplo prático da implementação da arquitetura **MVC (Model-View-Controller)** em Flutter, garantindo um código organizado, escalável e de fácil manutenção. O aplicativo se comunicará com uma API remota para salvamento e sincronização de dados em nuvem.

## 2. Funcionalidades Implementadas

* **Tela Inicial Dinâmica:** Uma tela de boas-vindas com um layout em grade (2x2) para acesso rápido às principais funções.
* **Navegação Principal:**
    * Cadastrar Cliente
    * Verificar Clientes Cadastrados (Em desenvolvimento)
    * Realizar Venda (Em desenvolvimento)
    * Emitir Relatórios (Em desenvolvimento)
* **Menu Lateral (Drawer):** Acesso a opções secundárias como "Configurações" e "Sobre".
* **Troca de Tema:** Um botão na barra de aplicativos permite alternar instantaneamente entre o tema claro (light) e escuro (dark).
* **Cadastro de Cliente:** Um formulário completo e validado para registrar novos clientes, separando dados pessoais e de endereço.

## 3. Arquitetura MVC

O projeto segue estritamente o padrão de arquitetura Model-View-Controller para garantir a separação de responsabilidades.

* **Model (Modelo):**
    * Responsável pela lógica de negócios e pela manipulação dos dados.
    * Contém as classes de dados (ex: `Client`) e a lógica para salvar, buscar ou processar informações.
    * Não tem conhecimento sobre a interface do usuário.
    * *Exemplo:* `register_client_model.dart`

* **View (Visão):**
    * Responsável pela apresentação da interface do usuário (UI).
    * É a camada que o usuário vê e com a qual interage (telas, botões, formulários).
    * Não contém lógica de negócios; apenas exibe os dados e notifica o Controller sobre as ações do usuário.
    * *Exemplos:* `home_screen.dart`, `register_client_screen.dart`

* **Controller (Controlador):**
    * Atua como uma ponte entre o Model e a View.
    * Recebe as ações do usuário a partir da View, processa-as (frequentemente delegando a lógica para o Model) e atualiza a View com os novos dados.
    * Gerencia o estado da View (ex: `TextEditingController`).
    * *Exemplo:* `register_client_controller.dart`

## 4. Estrutura do Projeto


lib/
├── main.dart                   # Ponto de entrada da aplicação, gerencia os temas.
|
├── home_screen.dart            # View: A tela principal com o menu em grade.
|
├── register_client_screen.dart # View: A tela de formulário para cadastro.
|
├── register_client_controller.dart # Controller: Gerencia o estado e a lógica do formulário de cadastro.
|
└── register_client_model.dart      # Model: Define a estrutura do cliente e a lógica de salvamento.


## 5. Como Executar o Projeto

### Pré-requisitos

* [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado.
* Um editor de código como [VS Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio).
* Um emulador Android ou iOS configurado, ou um dispositivo físico.

### Passos

1.  **Clone o repositório:**
    ```sh
    git clone https://github.com/Azsures/GIC_mobile/
    cd gic-app
    ```

2.  **Instale as dependências:**
    ```sh
    flutter pub get
    ```

3.  **Execute o aplicativo:**
    ```sh
    flutter run
    ```

## 6. Próximos Passos (Future Work)

* Implementar as telas de "Verificar Clientes", "Realizar Venda" e "Emitir Relatórios".
* Integração com API remota em Python para salvamento e sincronização de dados com aplicação desktop.
* Adicionar animações para uma experiência de usuário mais fluida.
* Criar testes unitários e de widgets para garantir a qualidade do código.

