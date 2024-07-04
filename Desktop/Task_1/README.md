generate the SSH key for EC2 instance using command "ssh-keygen"

There are 6 terraform files for VPC, EC2 instance, RDS Instance, Security Groups, Version for the AWS module and the variables files 
I havent cretaed any output variables file due to time constraint 

To build infrastructure using terrform, first type "terraform init" (download necessary plugins), than "terrfaorm apply" (to build infrastructure)

There tw files for ansible, inventory file and ansible yaml plybook 

To run the Ansible tasks type "ansible-playbook -i inventory main.yml"

I have created a static inventory file but can do it dynamically as well