# Outputs - Extracting Useful Information

Once we deploy a resource using Terraform, if we need any key information about the deploted resource to use externally then we can use **Outputs**

Example: 
We deploy an aws ec2 instance with Terraform and need to use its public IP in an Ansible playbook for post-deployment configurations (like installing dependencies and setting up environment variables).

**Terraform Output (outputs.tf)**

```cmd
output "instance_public_ip" {
  description = "Public IP Adress of AWS Instance"
  value = aws_instance.my_vm.public_ip
}
```

With the above output defined, we can now fetch the IP address in our ansible playbook:

**Fetching Output in Ansible Playbook**

```cmd
instance_ip=$(terraform output -raw instance_public_ip)
ansible-playbook -i "$instance_ip," -u ubuntu setup.yml
```

This will get the IP address of the deployed EC2 instance and use it in our ansible playbook
