# Application LoadBalancer Deploy
resource "aws_lb" "pro_alb" {
  name                   = "pro-alb"
  internal               = true
  load_balancer_type     = "application"
  security_groups        = [aws_security_group.pro_websg.id]
  subnets                = [aws_subnet.pro_pria.id,aws_subnet.pro_pric.id]


  tags = {
      "Name" = "pro-alb"
  }
}

# ALB_target group
resource "aws_lb_target_group" "pro_alb_tg" {   
    name     = "pro-alb-tg"
    port     = 80
    protocol = "HTTP"
    vpc_id   = aws_vpc.pro_vpc.id

    health_check {
      enabled              = true
      healthy_threshold    = 3
      interval             = 5
      matcher              = "200"
      path                 = "/health.html"
      port                 = "traffic-port"
      protocol             = "HTTP"
      timeout              = 2
      unhealthy_threshold  = 2
    }
}

# alb_listener
resource "aws_lb_listener" "pro_alb_list" {
    load_balancer_arn           = aws_lb.pro_alb.arn
    port                        = 80
    protocol                    = "HTTP"

    default_action {
      type                       = "forward"
      target_group_arn           = aws_lb_target_group.pro_alb_tg.arn
    }
}

resource "aws_lb_listener" "pro_alb_list_lb" {
    load_balancer_arn           = aws_lb.pro_alb.arn
    port                        = 8080
    protocol                    = "HTTP"

    default_action {
      type                       = "forward"
      target_group_arn           = aws_lb_target_group.pro_alb_tg.arn
    }
}

# alb_target grout_attachment
resource "aws_lb_target_group_attachment" "pro_alb_tg_att_pria" {
  target_group_arn       = aws_lb_target_group.pro_alb_tg.arn
  target_id              = aws_instance.pri_a.id
  port                   = 80
}
resource "aws_lb_target_group_attachment" "pro_alb_tg_att_pric" {
  target_group_arn       = aws_lb_target_group.pro_alb_tg.arn
  target_id              = aws_instance.pri_c.id
  port                   = 80
}