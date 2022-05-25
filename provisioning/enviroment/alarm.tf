# resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
#     alarm_name                = "StopTheInstanceAfterInactivity"
#     metric_name               = "CPUUtilization"
#     comparison_operator       = "LessThanOrEqualToThreshold"
#     statistic                 = "Average"
#     threshold                 = var.threshold
#     evaluation_periods        = var.evaluation_periods # The number of periods over which data is compared to the specified threshold
#     period                    = var.period # Evaluation Period (seconds)
#     namespace                 = "AWS/EC2"
#     alarm_description         = "This metric monitors ec2 cpu utilization and stop the instance if it is inactive"
#     actions_enabled           = "true"
#     alarm_actions             = ["arn:aws:automate:${var.region}:ec2:stop"]
#     ok_actions                = [] # do nothing
#     insufficient_data_actions = [] # do nothing
#     count                     = length(var.instance_name) # Create an alrarm for each instance name
#     dimensions                = {InstanceId = aws_instance.ec2_instance[count.index].id}
# }