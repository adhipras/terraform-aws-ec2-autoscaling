#-------------------------------------------------------------------------------
# Launch Template
#-------------------------------------------------------------------------------

resource "aws_launch_template" "autoscaling" {
  name          = "ec2-launch-template"
  image_id      = data.aws_ami.image.id
  instance_type = var.instance_type
}

#-------------------------------------------------------------------------------
# Autoscaling Group
#-------------------------------------------------------------------------------

resource "aws_autoscaling_group" "ec2" {
  name                = "autoscaling-group-ec2"
  vpc_zone_identifier = [aws_subnet.private.id]
  min_size            = var.min_size
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size

  launch_template {
    id = aws_launch_template.autoscaling.id
  }

  tag {
    key                 = "Name"
    value               = "ec2-autoscaling-group"
    propagate_at_launch = true
  }
}

#-------------------------------------------------------------------------------
# Autoscaling Policies
#-------------------------------------------------------------------------------

resource "aws_autoscaling_policy" "scale_up" {
  name                   = "ec2-autoscaling-up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.ec2.name
}

resource "aws_autoscaling_policy" "scale_down" {
  name                   = "ec2-autoscaling-down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.cooldown
  autoscaling_group_name = aws_autoscaling_group.ec2.name
}
