resource "aws_elb" "lb_files" {
  name            = var.alb_name
  subnets         = [aws_subnet.public_subnet.id]
  security_groups = [aws_security_group.http_from_internet.id]



  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  instances                   = aws_instance.public_instance.*.id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

}