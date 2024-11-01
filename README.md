# 🐾 Meopets

Bem-vindo ao **Meopets**, o seu espaço especial para homenagear e recordar os seus pets! Neste aplicativo, você pode adicionar os animais de estimação que fizeram parte da sua vida, seja para celebrar momentos felizes ou para lembrar os que já se foram. 

**Meopets** é uma simulação de Pokédex que permite que você crie um verdadeiro álbum de memórias dos seus bichinhos. Com uma interface simples e adorável, você poderá:

## Funcionalidades
- Adicionar pets;
- Remover pets;
- Editar pets [TODO];
- Adicionar lembranças e fotos com seus bichinhos [TODO].

## Tecnologias Usadas

- **Flutter**: Para desenvolver o aplicativo mobile.
- **JSON Server**: Para simular um banco de dados e armazenar os dados dos pets.

## Como Começar

Para rodar o Meopets localmente, siga os passos abaixo:

1. clone o repositório e navegue até sua pasta;
2. instale as dependências com `flutter pub get`;
3. em uma janela do terminal, acesse o diretório `database` e rode o comando `json-server --watch db.json`;
4. crie o arquivo `.env` com base no arquivo `env.example`, adicionando a porta em que você irá rodar o client;
5. rode o aplicativo com `flutter run`.

## Estrutura do projeto

```bash
- lib
  - app (dependências e inicialização do app)
  - config (configurações de ambiente)
  - src (código-fonte)
    - core 
      - network
    - design system
      - tokens
    - modules
      - create-pet
        - cubit
        - data
        - presentation
      - my-pet-details
        - cubit
        - data
        - presentation
      - my-pets
        - cubit
        - data
        - presentation
    - shared
```
