import { InputType, Field } from '@nestjs/graphql';

@InputType()
export class UpdateTodoInput {
  @Field()
  id: number;

  @Field({ nullable: true })
  title?: string;

  @Field({ nullable: true })
  completed?: boolean;
}
