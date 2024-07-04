resource "aws_db_subnet_group" "task-rds-sgrp" {
  subnet_ids = aws_subnet.PrivSub_1.id
  tags = {
    Name = "Subnet group for RDS"
  }
}


resource "aws_db_parameter_group" "task-rds-pgrp" {
  name   = "task-rds-pgrp"
  family = "mysql5.6"
}

resource "aws_db_instance" "task-rds" {
  allocated_storage     = 20
  storage_type          = "gp2"
  engine                = "mysql"
  engine_version        = "5.7.44"
  instance_class        = "db.t2.small"
  username              = var.dbuser
  password              = var.dbpass  # Replace with your own secure password

  parameter_group_name = aws_db_parameter_group.task-rds-pgrp.name
  publicly_accessible = true
  multi_az = true

  tags = {
    Name = "task-rds"
  }
  depends_on = [ aws_vpc.task-vpc, aws_security_group.task-rds-sg ]
}