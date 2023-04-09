locals {
  app_name = "todo-backend"
   container_port = jsondecode(aws_ecs_task_definition.nestjs_task_definition.container_definitions)[0].portMappings[0].containerPort
}