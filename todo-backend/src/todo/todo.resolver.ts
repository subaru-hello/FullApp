import { Resolver, Query, Mutation, Args } from '@nestjs/graphql';
import { PrismaService } from 'src/prisma.service';
import { TodoModel } from './dto/todo.model';
import { Todo } from '@prisma/client';
import { CreateTodoInput } from './dto/create-todo.input';
import { UpdateTodoInput } from './dto/update-todo.input';

@Resolver('Todo')
export class TodoResolver {
  constructor(private prisma: PrismaService) {}

  @Query(() => [TodoModel])
  async todos(): Promise<Todo[]> {
    const todos = await this.prisma.todo.findMany();
    return todos;
  }

  @Mutation(() => TodoModel, { nullable: true })
  async createTodo(
    @Args('createTodoInput') createTodoInput: CreateTodoInput,
  ): Promise<Todo> {
    return this.prisma.todo.create({
      data: {
        title: createTodoInput.title,
        completed: createTodoInput.completed,
      },
    });
  }

  @Mutation(() => TodoModel)
  async updateTodo(
    @Args('updateTodoInput') updateTodoInput: UpdateTodoInput,
  ): Promise<Todo> {
    return this.prisma.todo.update({
      where: { id: updateTodoInput.id },
      data: {
        title: updateTodoInput.title,
        completed: updateTodoInput.completed,
      },
    });
  }

  @Mutation(() => Boolean)
  async deleteTodo(@Args('id') id: number): Promise<boolean> {
    try {
      await this.prisma.todo.delete({ where: { id } });
      return true;
    } catch (error) {
      return false;
    }
  }
}
