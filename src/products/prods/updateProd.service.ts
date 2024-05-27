import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { ProductDTO } from './prods.dto'
import { PrismaService } from 'src/database/PrimsaService';
import { UpdateDTO } from './updateprods.dto';

@Injectable()
export class UpdatesService {

    constructor(private prisma: PrismaService) {}

    async update(id: string, data: UpdateDTO ){
        const prodExist = await this.prisma.product.findUnique({
            where:{
                id,
            }
        })

        if(!prodExist){
            throw new Error("This product hasn't been registered")
        }

        await this.prisma.product.update({
            data,
            where: {
                id,
            },
        })
    }

    async delete(id:string) {
        const prodExist = await this.prisma.product.findUnique({
            where:{
                id,
            }
        })

        if(!prodExist){
            throw new Error("This product hasn't been registered")
        }

        return await this.prisma.product.delete({
            where:{
                id,
            }
        })
    }

}