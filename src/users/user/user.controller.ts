import { Controller, Body, Post, Put, Delete, Param, Get} from '@nestjs/common';
import { UserService } from './user.service';
import { UserDTO } from './user.dto';
import { CartDTO } from './cart.dto';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @Post('register')
  async create(@Body() data: UserDTO){
    return this.userService.create(data);
  } 

  @Delete('all')
  async deleteUsers(){
    return this.userService.deleteAll()
  }

}

@Controller('cart')
export class CartController {

    constructor(private readonly userService: UserService) {}

    @Put()
    async addCart(@Body() data: CartDTO){
        return this.userService.addToCart(data);
    }

    @Get(":email")
    async seeCart(@Param("email") user:string){
        return this.userService.seeCart(user);
    }

    @Put(':email/finish')
    async placeOrder(@Param("email") user: string){
        return this.userService.placeOrder(user);
    }

    @Get(':email/orders')
    async seeOrders(@Param("email") user: string)
    {
      return this.userService.seeOrder(user);
    }


    @Delete()
    async deleteCart(@Body() data: CartDTO){
        return this.userService.deletefromCart(data);
    }

}
