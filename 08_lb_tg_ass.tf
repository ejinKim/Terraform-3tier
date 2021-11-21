# ALB
resource "aws_lb_target_group_attachment" "Final_alb_tg_ass_a" {
  target_group_arn = aws_lb_target_group.Final_alb_tg.arn
  target_id        = aws_instance.Final_web[0].id
  port             = 80
}

resource "aws_lb_target_group_attachment" "Final_alb_tg_ass_c" {
  target_group_arn = aws_lb_target_group.Final_alb_tg.arn
  target_id        = aws_instance.Final_web[1].id
  port             = 80
}

# NLB
resource "aws_lb_target_group_attachment" "Final_nlb_tg_ass_a" {
  target_group_arn = aws_lb_target_group.Final_nlb_tg.arn
  target_id        = aws_instance.Final_was[0].id
  port             = 8080
}

resource "aws_lb_target_group_attachment" "Final_nlb_tg_ass_c" {
  target_group_arn = aws_lb_target_group.Final_nlb_tg.arn
  target_id        = aws_instance.Final_was[1].id
  port             = 8080
}