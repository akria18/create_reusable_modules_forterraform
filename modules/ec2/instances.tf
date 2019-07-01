#creation of the ec2

resource "aws_instance" "web" {
  count         ="${var.ec2_count}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${var.subnet_id}"
  tags = {
    Name = "instance_create"
  }
}





#creation of the ALB

resource "aws_alb" "ALB" {

  internal ="${var.internal}"
#to get it from vars output vpc
/* security_groups = "${var.security_groups}"  
  subnets  = "${var.subnet}" */
  enable_detection_protection = "${var.enable_detection_protection}"
  tags = {
    Name = "Load_balancer"
}
}




#creation of the target group

resource "aws_alb_target_group" "aws_target_group" {
  vpc_id = "${var.vpc_id}"   
  port = "${var.port}"
  protocol = "${var.protocol}"
  health_check {
    path = "/healthcheck"
    port = "${var.port}"
    protocol = "${var.protocol}"
    healthy_threshold = "${var.healthy_threshold}"
    unhealthy_threshold = "${var.unhealthy_threshold}"
    interval = "${var.interavl}"
    timeout = "${var.timeout}"
     }   
  tags = {
    Name = "alb_target_group "
   
}

}



#Assignement of the EC2 to the target group 

resource "aws_alb_target_group_attachment"  "aws_target_group" {
  
  tags = {
    Name = "aws_target_group"

}

}

