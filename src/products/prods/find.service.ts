import { Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { ProductDTO } from './prods.dto'
import { PrismaService } from 'src/database/PrimsaService';

@Injectable()
export class FindProdsService {
    constructor(private prisma: PrismaService) {}

    async findAvailable()
    {
        return this.prisma.product.findMany({
            where:{
                quantity:{
                    not: 0,
                },
            },
        });
    }

    async findAll()
    {
        return this.prisma.product.findMany();
    }

    async findSpecific(name: string)
    {
        return this.prisma.product.findMany({
            where: {
                name:{
                    contains: name,
                }
            }
        })
    }
}