# tf-012-create-three-instances-demo

# tf-012-autoscaling-events-demo

Creates demo stack with Oracle Cloud Infrastructure (OCI) using Terraform 0.12 which creates three instances using modules and dynamic blocks to reduce necessary amount of code.

Running this creates following resources:


* Compartment
* Virtual Cloud Network (VCN)
* Internet Gateway
* One public subnet for the instance pool instances (port 22 is open to public and all VCN traffic allowed)
* Public routetable - Public RT will have a route to Internet Gateway 
* Public securitylist - Allows traffic to port 22. By default allows traffic from any source but this can be modified to allow only traffic from CIDR block deemed necessary
* Three compute instances with the smallest shape on a 7.6 linux image - public IPs will be displayed in the end. 

## Requirements and install instructions

1. Valid OCI account to install these components
2. Download these .tf files
3. Set following environment variables to your environment:

* TF_VAR_tenancy_ocid - Your tenancy OCID
* TF_VAR_user_ocid - Your user OCID which you are connecting to OCI
* TF_VAR_fingerprint - Fingerprint for your key found from user details
* TF_VAR_private_key_path - Path to your private key on your machine
* TF_VAR_region - region which you are using

4. Modify variables.tf and edit variable "ssh_public_key" to have your own SSH key defined.

5. Running Terraform:

* terraform init
* terraform plan !! Remember to review the plan !!
* terraform apply

6. Review the public IP of compute instance and the private IP's for compute instance. You can use the private ssh key and *opc* user to login to these instances

## Removal of stack

In case you want to remove created resources:

* terraform destroy

## Additional notes

You can freely change the variables in the variables.tf depending what you need. One could potentially try different amount of servers by adding new instance names. Try and test!

Thanks for [Stephen Cross](https://gist.github.com/scross01/bcd21c12b15787f3ae9d51d0d9b2df06) for the filtering of OCI images using specific OS version. 





