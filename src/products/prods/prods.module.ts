import { Module } from '@nestjs/common';
import { ProdsService } from './prods.service';
import { ProdsController, QueryController, UpdataeController } from './prods.controller';
import { PrismaService } from 'src/database/PrimsaService';
import { FindProdsService } from './find.service';
import { UpdatesService } from './updateProd.service';

@Module({
  controllers: [ProdsController, QueryController, UpdataeController],
  providers: [ProdsService, FindProdsService, PrismaService, UpdatesService],
})
export class ProdsModule {}
