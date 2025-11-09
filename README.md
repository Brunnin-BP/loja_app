Parte 1
# 🛍️ Loja App

Aplicativo de controle de produtos e vendas desenvolvido em **Flutter** com **persistência local em SQLite (sqflite_common_ffi)**.  
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

Parte 2

