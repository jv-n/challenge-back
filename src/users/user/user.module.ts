import { Module } from '@nestjs/common';
import { UserService } from './user.service';
import { CartController, UserController } from './user.controller';

import { PrismaService } from 'src/database/PrimsaService';

@Module({
  controllers: [UserController, CartController],
  providers: [UserService, PrismaService],
  exports: [UserService]
})
export class UserModule {}
