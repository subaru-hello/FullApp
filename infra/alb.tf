
/* ALB用のセキュリティグループ */
resource "aws_security_group" "alb_sg" {
  vpc_id   = aws_vpc.tb_vpc.id 
  name        = "alb-security-group"
  description = "Security group for the ALB"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/* ALB */
resource "aws_lb" "nestjs_alb" {
  name               = "nestjs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nestjs_sg.id]
  subnets            = [aws_subnet.tb_vpc_subnet_1.id, aws_subnet.tb_vpc_subnet_2.id]
}

resource "aws_lb_listener" "nestjs_listener" {
  load_balancer_arn = aws_lb.nestjs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nestjs_tg.arn
  }
}

/* ターゲットグループ */
resource "aws_lb_target_group" "nestjs_tg" {
  name     = "nestjs-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tb_vpc.id
  target_type = "ip"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}