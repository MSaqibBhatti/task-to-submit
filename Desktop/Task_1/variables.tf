# Input Variables

# AWS Region
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "us-east-1"  
}

variable vpc_name {
  default = "task-VPC"
}

variable vpc_cidr {
  default = "172.21.0.0/16"
}

variable az_1 {
  default = "us-east-1a"
}

variable az_2 {
  default = "us-east-1b"
}

variable PubSub_1 {
  default = "172.21.1.0/24"
}

variable PubSub_2 {
  default = "172.21.2.0/24"
}

variable PrivSub_1 {
  default = "172.21.3.0/24"
}

variable PrivSub_2 {
  default = "172.21.4.0/24"
}

variable ami {
    default = "ami-0947d2ba12ee1ff75"
}

variable instance_type {
    default = "t2.small"
}

variable myIP{
    default = "154.72.72.10"
}

variable dbuser{
    default = "admin"
}

variable dbpass{
    default = "admin123"
}