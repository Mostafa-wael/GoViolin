variable "server_name" {
description = "The server name"
default = "GoViolin"
}
variable "access_key" {
description = "My AWS access key"
}
variable "secret_key" {
description = "My AWS secret key"
}



# Related to the Region
variable "region" {
default = "us-east-2"
}
variable "availability_zone" {
default = "us-east-2a"
}

# Related to Networking
variable "vpc_cidr" {
default = "178.0.0.0/16"
}
variable "public_subnet_cidr" {
default = "178.0.10.0/24"
}

# Related to the Alarm
variable "threshold" {
description = "Take action when CPU utilization is less than this value"
default = 0.15
}
variable "evaluation_periods" {
description = "The number of periods over which data is compared to the specified threshold"
default = 2
}
variable "period" {
description = "Evaluation Period (seconds)"
default = 600
}


# Related to the Instance
variable "instance_name" {
description = "The list of the instance names to be created"
default = ["GoViolin"] 
}
variable "instance_type" {
default = "t2.micro"
}
variable "instance_ami" {
default = "ami-0fb653ca2d3203ac1"
}
variable "instance_key" {
default = "test-web-server"
}
variable "instance_start_script" {
description = "The start script to be executed on the instance"
default = <<-EOF
  #!/bin/bash
  echo "Initializing environment..."
  sudo apt-get update 

  # echo "Install Jenkins..."
  # wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
  # sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  # sudo apt update -y
  # sudo apt install openjdk-8-jre -y
  # sudo apt install jenkins -y

  echo "Install Docker"
  sudo apt-get update -y
  sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update -y
  sudo apt-get install docker-ce docker-ce-cli containerd.io -y
  sudo chmod 666 /var/run/docker.sock
  docker pull mostafaw/goviolin:latest


  EOF
}
