module "mrp_vpc" {
    source = "../module/vpc"
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
}

module "mrp_rds" {
    source = "../module/rds"
    ENVIRONMENT = var.ENVIRONMENT
    AWS_REGION = var.AWS_REGION
}

# Define Security Group for the App
resource "aws_security_group" "mrp_app" {
    tags = {
        Name = "${var.ENVIRONMENT}-mrp-app"
    }

    name = "${var.ENVIRONMENT}-mrp-app"
    description = "Created by MRP"
    vpc_id = module.mrp_vpc.my_vpc_id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.SSH_CIDR_APP}"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

# Resource Key-Pair
resource "aws_key_pair" "mrp_key" {
    key_name = "mrp_key"  
    public_key = file(var.public_key_path)
}

# Define Auto Scaling Launch Configuration
resource "aws_launch_configuration" "launch_config_app" {
    name = "launch_config_app"  
    image_id = lookup(var.AMIS, var.AWS_REGION)
    instance_type = var.INSTANCE_TYPE
    user_data = "#!/bin/bash\napt-get update\napt-get -y install net-tools nginx\nMYIP=`ifconfig | grep -E '(inet 10)|(addr:10)' | awk '{ print $2 }' | cut -d ':' -f2`\necho 'Hello Guys\nThis is the EC2 IP: '$MYIP > /var/www/html/index.html"
    security_groups = [ aws_security_group.mrp_app.id ]
    key_name = aws_key_pair.mrp_key.key_name

    root_block_device {
      volume_type = "gp2"
      volume_size = "20"
    }
}

# Define AWS Autoscaling group
resource "aws_autoscaling_group" "mrp_asg" {
    name = "mrp_asg"  
    max_size = 2
    min_size = 1
    health_check_grace_period = 30
    health_check_type = "EC2"
    desired_capacity = 1
    force_delete = true
    launch_configuration = aws_launch_configuration.launch_config_app.name
    vpc_zone_identifier = ["${module.mrp_vpc.public_subnet_1_id}","${module.mrp_vpc.public_subnet_2_id}"]
    target_group_arns = [aws_lb_target_group.load-balancer-target_group.arn]
}

# Application Load Balancer for App Server
resource "aws_alb" "mrp-load-balancer" {
    name = "${var.ENVIRONMENT}-mrp-lb"  
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.mrp_app_alb.id]
    subnets = [ "${module.mrp_vpc.public_subnet_1_id}", "${module.mrp_vpc.public_subnet_2_id}" ]
}

# Add Target Groups
resource "aws_alb_target_group" "load-balancer-target-group" {
    name = "load-balancer-target-group"  
    port = 80
    protocol = "HTTP"
    vpc_id = module.mrp_vpc.my_vpc_id
}

# Adding HTTP Listener
resource "aws_lb_listener" "app_listener" {
    load_balancer_arn = aws_lb.mrp-load-balancer.arn
    port = "80"  
    protocol = "HTTP"

    default_action {
      target_group_arn = aws_lb_target_group.load-balancer-target-group.arn
      type = "forward"
    }
}

output "load-balancer-output" {
    value = aws_alb.mrp-load-balancer.dns_name  
}