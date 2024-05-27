import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { ProductDTO } from './prods.dto'
import { PrismaService } from 'src/database/PrimsaService';

@Injectable()
export class ProdsService {

    constructor(private prisma: PrismaService) {}

    async create(data: ProductDTO) {

        const prodExist = await this.prisma.product.findFirst({
            where:{
                id: data.id
            }
        })

        if(prodExist){
            throw new Error('Product already registered');
        }
        
        const prods = await this.prisma.product.create({
            data,
        });

    }

    
};
