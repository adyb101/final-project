# nlb Deploy
resource "aws_lb" "pro_nlb" {
  name                   = "pro-nlb"
  internal               = false
  load_balancer_type     = "network"
  subnets                = [aws_subnet.pro_puba.id,aws_subnet.pro_pubc.id]

  tags = {
      "Name" = "pro-nlb"
  }
}

# NLB_target group
resource "aws_lb_target_group" "pro_nlb_tg" {   
    name        = "pro-nlb-tg"
    port        = 8080
    protocol    = "TCP"
    vpc_id      = aws_vpc.pro_vpc.id
    target_type = "alb"
}

# NLB_listener
resource "aws_lb_listener" "pro_nlb_list" {
    depends_on = [aws_lb.pro_alb]
    load_balancer_arn           = aws_lb.pro_nlb.arn
    port                        = "80"
    protocol                    = "TCP"

    default_action {
      type                       = "forward"
      target_group_arn           = aws_lb_target_group.pro_nlb_tg.arn
    }
}

# NLB_target group_attachment
resource "aws_lb_target_group_attachment" "pro_nlb_tg_att" {
  target_group_arn       = aws_lb_target_group.pro_nlb_tg.arn
  target_id              = aws_lb.pro_alb.arn
  port                   = 8080
}