
## Installation

```bash
$ npm install
```

## Running the app

```bash
# development
$ npm run start

# watch mode
$ npm run start:dev
```
## Como estruturei

Tem que haver um usuario registrado para adicionar produtos, também já registrados, no próprio carrinho.
adiciona um usuário com body:
``` 
{
  "name": "example",
  "email": "example",
  "password":"example"
} ```

Para registrar produtos:
``` 
{
  "id": "00x",
  "name": "example",
  "desc": "about"
  "price": 99.99,
  "quantity":99
} ```

Para adicionar um produto ao carrinho em GET {localhost}/user/cart:
```
{
  "id":"00x",
  "email": "example",
  "quantity": 2
}```
Remover é a mesma coisa com um Delete

