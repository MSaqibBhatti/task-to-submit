resource "aws_key_pair" "task-key" {
    key_name = "task-key"
    public_key = file("task-key.pub")
}

resource "aws_instance" "task_inst" {
  ami = var.ami
  instance_type = var.instance_type
  availability_zone = var.az_1
  key_name = aws_key_pair.task-key.key_name
  subnet_id = aws_subnet.PubSub-1.id
  vpc_security_group_ids = ["aws_security_group.task-ec2_sg.id"]
  tags = {
    Name = "task-ec2"
  }
  depends_on = [ aws_vpc.task-vpc, aws_security_group.task-ec2_sg ]
}