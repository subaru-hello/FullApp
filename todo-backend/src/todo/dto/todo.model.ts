import { Field, GraphQLISODateTime, ID, ObjectType } from '@nestjs/graphql';
@ObjectType()
export class TodoModel {
  @Field((type) => ID)
  id: string;

  @Field((type) => String)
  title: string;

  @Field((type) => Boolean, { nullable: true })
  completed: boolean;

  @Field((type) => GraphQLISODateTime, { nullable: true })
  createdAt?: Date;
}
