import { Module } from '@nestjs/common';
import { ProdsModule } from './products/prods/prods.module';
import { UserModule } from './users/user/user.module';


@Module({
  imports: [ProdsModule, UserModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
