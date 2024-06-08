
# Application Load Balancer
resource "aws_lb" "public_lb" {
  name               = "public-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_security_group_id]
  subnets            = var.public_subnet_ids

  tags = {
    Name = "Public Load Balancer"
  }
}

# Target Groups
resource "aws_lb_target_group" "frontend_tg" {
  name     = "frontend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled  = true
    path     = "/"
    protocol = "HTTP"
    matcher  = "200"
  }
}

resource "aws_lb_target_group" "backend_tg" {
  name     = "backend-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled  = true
    path     = "/api"
    protocol = "HTTP"
    matcher  = "200"
  }
}

resource "aws_lb_target_group" "metabase_tg" {
  name     = "metabase-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled  = true
    path     = "/metabase"
    protocol = "HTTP"
    matcher  = "200"
  }
}

# HTTPS Listener
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.public_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

# HTTP Listener (Redirect to HTTPS)
resource "aws_lb_listener" "http_redirect" {
  load_balancer_arn = aws_lb.public_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Listener Rules for Backend and Metabase
resource "aws_lb_listener_rule" "backend_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }

  condition {
    path_pattern {
      values = ["/api*"]
    }
  }
}

resource "aws_lb_listener_rule" "metabase_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.metabase_tg.arn
  }

  condition {
    path_pattern {
      values = ["/metabase*"]
    }
  }
}

# Register EC2 instances with the target groups
resource "aws_lb_target_group_attachment" "frontend_tg_attachment" {
  target_group_arn = aws_lb_target_group.frontend_tg.arn
  target_id        = var.frontend_instance_id 
  port             = 80
}

resource "aws_lb_target_group_attachment" "backend_tg_attachment" {
  target_group_arn = aws_lb_target_group.backend_tg.arn
  target_id        = var.backend_instance_id
  port             = 80
}

resource "aws_lb_target_group_attachment" "metabase_tg_attachment" {
  target_group_arn = aws_lb_target_group.metabase_tg.arn
  target_id        = var.metabase_instance_id
  port             = 80
}
