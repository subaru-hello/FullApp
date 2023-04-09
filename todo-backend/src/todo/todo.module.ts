import { Module } from '@nestjs/common';
import { TodoResolver } from './todo.resolver';
import { PrismaService } from 'src/prisma.service';

@Module({
  providers: [TodoResolver, PrismaService],
})
export class TodoModule {}
