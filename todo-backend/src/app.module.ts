import { Module } from '@nestjs/common';
import { GraphQLModule } from './graphql/graphql.module';
import { TodoModule } from './todo/todo.module';
import { AppController } from './app.controller';
import { AppService } from './app.service';
@Module({
  imports: [GraphQLModule, TodoModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
