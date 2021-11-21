# ALB
resource "aws_lb" "Final_alb" {
  name               = "Final-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Final_alb_sg.id]
  subnets            = aws_subnet.Final_pub_subnet.*.id
/* 
    access_logs {
    bucket  = aws_s3_bucket.elb_s3_bucket.bucket
    prefix  = "test-lb"
    enabled = true
  }
*/
 depends_on = [
     aws_instance.Final_web
 ]

}

# alb tg
resource "aws_lb_target_group" "Final_alb_tg" {
  name        = "Final-alb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id = aws_vpc.Final_vpc.id

    health_check {
      enabled             = true
      healthy_threshold   = 3
      interval            = 5
      matcher             = "200" 
      path                = "/"
      port                = "traffic-port"
      protocol            = "HTTP"
      timeout             = 2
      unhealthy_threshold = 2
    }
}

# alb listener
resource "aws_lb_listener" "Final_alb_listener_http" {
  load_balancer_arn = aws_lb.Final_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Final_alb_tg.arn
  }
}

/*
 resource "aws_lb_listener" "Final_alb_listener_https"{
     load_balancer_arn = aws_lb.Final_alb.arn
     port = "443"
     protocol = "HTTPS"

     default_action {
       type = "forward"
       target_group_arn = aws_lb_target_group.Final_alb_tg.arn
     }
 }
*/

# NLB
resource "aws_lb" "Final_nlb" {
  name               = "Final-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = aws_subnet.Final_web_subnet.*.id
  depends_on = [
     aws_instance.Final_was
  ]
}

# nlb tg
resource "aws_lb_target_group" "Final_nlb_tg" {
    name = "Final-nlb-tg"
    port = 8080
    protocol = "TCP"
    vpc_id = aws_vpc.Final_vpc.id
}

# nlb listener
resource "aws_lb_listener" "Final_nlb_listener" {
    load_balancer_arn = aws_lb.Final_nlb.arn
    port = "8080"
    protocol = "TCP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.Final_nlb_tg.arn
    } 
}