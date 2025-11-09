# Parte 1
# 🛍️ Loja App

Aplicativo de produtos e vendas desenvolvido em **Flutter** com persistência local em SQLite.  
O objetivo do sistema é permitir o gerenciamento de produtos e o registro de vendas, funcionando tanto em ambiente **desktop (Windows)** quanto **mobile**.

---

## 📱 Funcionalidades

- Cadastro de produtos com:
  - Nome  
  - Categoria  
  - Preço  
  - Estoque  
  - Descrição  
- Listagem e exclusão de produtos  
- Registro de vendas, vinculando o produto e o cliente  
- Banco de dados local SQLite gerenciado por **sqflite_common_ffi**
- Arquitetura organizada em camadas (`data`, `models`, `repository`)

---

## 🏗️ Tecnologias utilizadas

| Tecnologia | Descrição |
|-------------|------------|
| Flutter | Framework principal para desenvolvimento multiplataforma |
| Dart | Linguagem de programação |
| Sqflite / Sqflite FFI | Persistência de dados local |
| Path | Manipulação de caminhos para o banco de dados |
| Android Studio | IDE utilizada no desenvolvimento |

---

## 🧱 Estrutura do projeto
lib/
├── data/
│ ├── database_helper.dart
│ └── repository.dart
├── models/
│ ├── produto.dart
│ └── venda.dart
├── main.dart

---

## ⚙️ Configuração do banco de dados

O banco de dados é criado automaticamente na primeira execução.  
Ele contém as seguintes tabelas:

- **produtos**
  - `id` (PRIMARY KEY)
  - `nome`
  - `categoria`
  - `preco`
  - `estoque`
  - `descricao`
- **vendas**
  - `id` (PRIMARY KEY)
  - `idProduto`
  - `quantidade`
  - `valorTotal`
  - `data`
  - `cliente`

---

## 🚀 Como executar o projeto

1. **Clone o repositório:**
   ```bash
     git clone https://github.com/seuusuario/loja_app.git
   
2. Entre na pasta:
   ```bash
      cd loja_app.
3. Instale as dependências:
   ```bash
     flutter pub get

4. Execute o projeto (Windows):
   ```bash
    flutter run -d windows
---

# Parte 2

📱 Aplicativo Flutter — Integração e Gerenciamento de Estado
🧩 Descrição Geral

Esta etapa do projeto tem como objetivo construir um aplicativo Flutter completo, com persistência local de dados (SQLite), navegação entre telas, validação de formulários e gerenciamento de estado com Provider.

O sistema implementa duas entidades principais:

Produtos — com nome, categoria, preço, estoque e descrição.

Vendas — associadas a produtos, com informações de cliente, quantidade, valor total e data.

O usuário pode realizar todas as operações CRUD (Create, Read, Update, Delete) diretamente pela interface gráfica.

---

🧠 Objetivos da Etapa

Integrar as camadas do sistema (Model → Repository → Provider → UI);

Aplicar gerenciamento de estado reativo com o pacote Provider;

Criar uma navegação funcional entre telas com rotas nomeadas;

Garantir persistência local dos dados utilizando SQLite (via sqflite_common_ffi);

Implementar validação e interação de formulários no Flutter;

Demonstrar relacionamento entre entidades (Produto ↔ Venda).

---

🏗️ Arquitetura Implementada

A aplicação segue uma arquitetura em camadas, separando responsabilidades:
lib/
 ├─ main.dart                → Ponto de entrada da aplicação
 ├─ models/                  → Classes de modelo (Produto, Venda)
 ├─ data/                    → Camada de persistência e repositórios
 │   ├─ database_helper.dart → Configuração e criação do banco SQLite
 │   └─ repository.dart      → Métodos CRUD para produtos e vendas
 ├─ providers/               → Gerenciamento de estado (Provider)
 │   ├─ produto_provider.dart
 │   └─ venda_provider.dart
 └─ screens/                 → Interface do usuário
     ├─ produtos_list_screen.dart → Lista de produtos
     ├─ produto_form_screen.dart  → Cadastro/edição de produtos
     ├─ vendas_list_screen.dart   → Lista de vendas
     └─ venda_form_screen.dart    → Cadastro/edição de vendas

---

🔁 Fluxo de Dados

- O usuário interage com os widgets nas telas.

- Os Providers notificam mudanças de estado.

- Os Repositórios acessam o banco de dados.

- A interface é atualizada automaticamente via notifyListeners().

---

⚙️ Tecnologias Utilizadas
Tecnologia	Finalidade
Flutter	Framework principal do app
Provider	Gerenciamento de estado reativo
Sqflite + sqflite_common_ffi	Persistência local em SQLite (suporte a desktop e mobile)
Path	Manipulação de caminhos de arquivos para o banco
Material Design	Padrão visual das telas

---

🧭 Funcionalidades Implementadas
1. CRUD de Produtos

- Cadastrar novos produtos;

- Editar produtos existentes;

- Excluir produtos;

- Listagem com ListView e exclusão por deslizar (Dismissible).

2. CRUD de Vendas

- Cadastrar novas vendas;

- Editar e excluir registros;

- Selecionar produto via DropdownButtonFormField;

- Cálculo automático do valor total (preço × quantidade).

3. Navegação

- Uso de rotas nomeadas (Navigator.pushNamed) entre telas;

- Retorno automático à tela de listagem após salvar ou excluir;

- Botão de atalho entre telas de Produtos e Vendas.

4. Validação de Formulários

- Implementação de Form e TextFormField com regras de validação;

- Mensagens de erro para campos obrigatórios e valores inválidos;

- Validação específica para quantidade e preço.

---

🧩 Gerenciamento de Estado

A biblioteca Provider foi escolhida por ser:

- Oficialmente recomendada pela equipe do Flutter;

- Simples de implementar e integrar com widgets ChangeNotifier;

- Facilmente escalável para múltiplos tipos de dados;

- Compatível com a arquitetura MVVM/MVC utilizada no projeto.

🔹 Estrutura de Conexão (Repository ↔ Provider ↔ UI)

O gerenciamento de estado foi implementado através de classes que intermediam o acesso entre a camada de dados (Repository) e a interface do usuário (UI).

- A UI (por exemplo, a tela de lista de produtos) não acessa o banco de dados diretamente.

- Ela interage com o Provider, que contém os métodos de manipulação de dados (carregar, salvar, atualizar, excluir).

- O Provider chama o Repository, que executa as operações CRUD no banco SQLite.

- Após a operação, o Provider executa notifyListeners(), notificando os widgets dependentes para atualizar automaticamente a interface.

---

▶️ Execução do Projeto
![Image](https://github.com/user-attachments/assets/a6d4ddb8-6e97-46ca-830d-eedef0c0a819)

---

▶️  Exclusão
![Image](https://github.com/user-attachments/assets/0315cb20-2d09-4c3f-bdbd-1bbd984f78c0)

---

# Parte 3
🧪 Testes Automatizados — Validação de Lógica e Interface
📘 Introdução

Esta terceira etapa tem como foco garantir a qualidade e robustez do aplicativo por meio de testes automatizados utilizando a ferramenta nativa do Flutter:
flutter_test.

O objetivo é validar tanto a lógica de negócios (camada de repositório e persistência) quanto a interatividade da interface (camada de apresentação), assegurando que todas as funcionalidades críticas — como criar, listar, atualizar e deletar — funcionem conforme o esperado.

---

⚙️ 1. Preparação do Ambiente de Testes
🔹 Estrutura de Diretórios

O Flutter já cria, por padrão, uma pasta chamada test/ na raiz do projeto.
Todos os arquivos de teste foram adicionados a essa estrutura

---

🧩 Teste de Widget mais relevante: 
# Teste 5 – Exibir mensagem quando não há produtos
🔍 Esse teste verifica se a interface exibe corretamente a mensagem de estado vazio quando não há produtos cadastrados. Ele simula o carregamento da tela com uma lista vazia e espera encontrar o texto:
`expect(find.text('Nenhum produto cadastrado'), findsOneWidget);`
🧠 Por que é importante:
Esse teste garante que o usuário receba feedback visual claro quando não há dados para mostrar. Isso evita:
- Telas em branco sem explicação.
- Confusão sobre se o app está carregando ou com erro.
- Experiência negativa por falta de comunicação visual.
Além disso, esse tipo de teste ajuda a validar o comportamento assíncrono da tela, como o uso de FutureBuilder, Provider e loading.

---

🧪 Teste de Unidade mais complexo:
# Teste 3 - Atualizar Produto
🔍 Esse teste verifica se o sistema consegue atualizar corretamente os dados de um produto existente. Ele envolve:
• 	Criar um produto inicial.
• 	Atualizar esse produto com novos dados.
• 	Verificar se os dados atualizados foram persistidos corretamente.
🧠 Por que é importante:
Esse teste garante que a lógica de atualização no repositório está funcionando corretamente. Isso é essencial para evitar bugs como:
• 	Dados antigos sendo exibidos após uma edição.
• 	Atualizações não sendo salvas.
• 	Produtos duplicados em vez de atualizados.
Sem esse teste, o usuário poderia editar um produto e não ver a mudança refletida — o que comprometeria a confiança no sistema

---

🧼 Principais melhorias do Clean Code
1. Legibilidade
- Código fácil de entender por humanos.
- Nomes de variáveis, funções e classes descritivos e consistentes.
- Evita abreviações obscuras e siglas sem contexto.
2. Simplicidade
- Faz apenas o necessário, sem complexidade desnecessária.
- Divide problemas grandes em partes pequenas e simples.
- Evita sobreengenharia.

---

▶️ Execução do Teste
![Image](https://github.com/user-attachments/assets/d8125afa-f0d5-4c47-baef-94361dac0519)

---






