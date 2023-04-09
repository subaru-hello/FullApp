
/* ECS Cluster */
resource "aws_ecs_cluster" "nestjs_cluster" {
  name = local.app_name
}

/* ECS task */
resource "aws_ecs_task_definition" "nestjs_task_definition" {
  family                   = local.app_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([{
    name      = local.app_name
    image     = var.ecr_image
    essential = true

    portMappings = [
      {
        containerPort = 3000
      }
    ]
  }])
}

/* ECS Service */
resource "aws_ecs_service" "nestjs_service" {
  name            = local.app_name
  cluster         = aws_ecs_cluster.nestjs_cluster.id
  task_definition = aws_ecs_task_definition.nestjs_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.nestjs_tg.arn
    container_name   = local.app_name
    container_port   = 3000
  }

  network_configuration {
    subnets          = [aws_subnet.tb_vpc_subnet_1.id, aws_subnet.tb_vpc_subnet_2.id]
    security_groups  = [aws_security_group.nestjs_sg.id]
  }
}
