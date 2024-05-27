import { Injectable } from '@nestjs/common';
import { Prisma, PrismaClient } from '@prisma/client';
import { PrismaService } from 'src/database/PrimsaService';
import { UserDTO } from './user.dto';
import { CartDTO } from './cart.dto';


@Injectable()
export class UserService {

    constructor(private prisma: PrismaService) {}
    
    async create(data: UserDTO){
        const userExits = await this.prisma.user.findFirst({
            where:{
                email:data.email
            }
        })

        if(userExits){
            throw new Error("User with this email already registered")
        }

        const users = await this.prisma.user.create({
            data,
        });

        const carts = await this.prisma.cart.create({
            data: {
                userEmail:data.email
            }
        })
    }

    async addToCart(body: CartDTO)
    {
        const productExists = await this.prisma.product.findFirst({
            where:{
                id:body.id
            }
        })

        if(!productExists){
            throw new Error("Product doesn't exist")
        }
        
        if(productExists.quantity === 0)
        {
            throw new Error("Product unavailable")
        }

        if(body.quantity>productExists.quantity){
            throw new Error("Product not available in this quantity")
        }

        await this.prisma.product.update({
            where:{
                id: body.id,
            },
            data: {
                quantity: {decrement: body.quantity}
            }
        })
        
        await this.prisma.cart.update({
             where: {
                 userEmail: body.email
             },
             data: {
                 products: {
                    connectOrCreate: {
                        where:{
                            cartId_productId: {
                                productId: body.id,
                                cartId: body.email
                            }
                        },
                        create: {
                            price_unic: productExists.price,
                            price_total: productExists.price,
                            productId: body.id,
                        }

                    }
                 }
            }
        })

        const oncart = await this.prisma.productsOnCart.update({
            where:{
                cartId_productId: {
                    productId: body.id,
                    cartId: body.email
                }
            },
            data: {
                prod_amount: { increment: body.quantity},
                price_total: productExists.price
            }
        })

        await this.prisma.productsOnCart.update({
            where:{
                cartId_productId: {
                    productId: body.id,
                    cartId: body.email
                }
            },
            data: {
                price_total: {multiply: oncart.prod_amount}
            }
        })


    }

    async deletefromCart(body: CartDTO)
    {
        const item = await this.prisma.productsOnCart.findUnique({
            where:{
                cartId_productId: {
                    productId: body.id,
                    cartId: body.email
                }
            }
        })

        if(!item){throw new Error("Item not in cart")};

        await this.prisma.product.update({
            where: {
                id:body.id
            },
            data: {
                quantity: {increment: body.quantity}
            }
        })

        const removed = await this.prisma.productsOnCart.update({
            where:{
                cartId_productId: {
                    productId: body.id,
                    cartId: body.email
                }
            }, 
            data:{
                prod_amount: { decrement: body.quantity },
                price_total: item.price_unic
            }
        })

        await this.prisma.productsOnCart.update({
            where:{
                cartId_productId: {
                    productId: body.id,
                    cartId: body.email
                }
            },
            data:{
                price_total: {multiply: removed.prod_amount}
            }
        })

        if(removed.prod_amount === 0)
        {
            await this.prisma.productsOnCart.delete({
                where:{
                    cartId_productId: {
                        productId: body.id,
                        cartId: body.email
                    }
                }
            })
        }
    }

    async placeOrder(user: string)
    {
        const carrinho = await this.prisma.productsOnCart.aggregate({
            where: {
                cartId: user,
            },
            _sum:{
                price_total: true,
            }
        })

        const neworder = await this.prisma.order.create({
            data: {
                user: user,
                order_total: carrinho._sum.price_total,
            }
        })

        await this.prisma.productsOnCart.deleteMany({
            where:{
                cartId: user,
            }
        })

    }

    async seeCart(user: string){
        return await this.prisma.productsOnCart.findMany({
            where: {
                cartId: user
            }
        })
    }

    async seeOrder(user: string)
    {
        return await this.prisma.order.findMany({
            where: {
                user: user,
            }
        })
    }

    async findSpecific(email: string)
    {
        return this.prisma.user.findUnique({
            where:{
                email,
            }
        })
    }

    async deleteAll()
    {
        await this.prisma.productsOnCart.deleteMany();
        await this.prisma.cart.deleteMany();
        return this.prisma.user.deleteMany();
    }
}
