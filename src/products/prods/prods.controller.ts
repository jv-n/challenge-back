import { Controller, Post, Body, Get, Put, Param, Delete } from '@nestjs/common';
import { ProdsService } from './prods.service';
import { FindProdsService } from './find.service';
import { UpdatesService } from './updateProd.service';
import { ProductDTO } from './prods.dto';
import { UpdateDTO } from './updateprods.dto';

@Controller('addprods')
export class ProdsController {
  constructor(private readonly prodsService: ProdsService) {}

  @Post()
  async create(@Body() data: ProductDTO){
    return this.prodsService.create(data);
  }
}

@Controller('search')

  export class QueryController{
    constructor (private readonly findProds: FindProdsService) {}

    @Get('stocked')
    async findAvailable()
    {
      return this.findProds.findAvailable();
    }

    @Get('all')
    async findAll()
    {
      return this.findProds.findAll();
    }

    @Get(':name')
    async findSpecific(@Param("name") name: string)
    {
      return this.findProds.findSpecific(name);
    }
  }

@Controller('update')
  export class UpdataeController{
    
    constructor (private readonly updateProds: UpdatesService) {}
    
    @Put(":id")
    async update(@Param("id") id: string, @Body() data : UpdateDTO){
      return this.updateProds.update(id, data);
    }
    
    @Delete(":id")
    async delete(@Param("id") id: string){
      return this.updateProds.delete(id);
    }

  }