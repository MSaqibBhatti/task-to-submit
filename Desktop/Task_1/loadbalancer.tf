resource "aws_lb" "task-alb" {
    name               = "test-lb-tf"
    internal           = false
    load_balancer_type = "network"
    subnets            = [aws_subnet.PubSub-1.id, aws_subnet.PubSub-2.id]
    security_groups = [aws_security_group.task-alb_sg.id]
    vpc_id      = aws_vpc.task-vpc.id
    enable_deletion_protection = true

    tags = {
        Name = "task-alb"
  }
  depends_on = [ aws_vpc.task-vpc, aws_security_group.task-alb_sg,aws_instance.task_inst ]
}


resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.task-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.task-tg.arn
  }
}


resource "aws_lb_target_group" "task-tg" {
  name     = "task-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.task-vpc.id
  target_type = "instance"
  load_balancing_cross_zone_enabled = "false"
  deregistration_delay = 10
  protocol_version = "HTTP1"
}


resource "aws_lb_target_group_attachment" "task-ec2-tg" {
  target_group_arn = aws_lb_target_group.task-tg.arn
  target_id        = aws_instance.task_inst.id
  port             = 80
  depends_on = [ aws_instance.task_inst ]
}