
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
```bash
{
  "name": "example",
  "email": "example",
  "password":"example"
}
```

Para registrar produtos:
```bash 
{
  "id": "00x",
  "name": "example",
  "desc": "about"
  "price": 99.99,
  "quantity":99
}
```
Para buscar e ver um produto: 
- GET {localhos}/serach/{algo_do_nome} => vê um produto especifico
- GET {localhost}/serach/all => vê todos os produtos
- GET {localhost}/search/available => vê todos os produtos ainda com estoque

Para adicionar um produto ao carrinho em PUT {localhost}/user/cart:
``` bash
{
  "id":"00x",
  "email": "example",
  "quantity": 2
}
```
Remover é a mesma coisa com um DEL,

entre outras coisas.
