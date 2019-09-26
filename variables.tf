/*

These are variables to create basic environment in Oracle Cloud Infrastructure.

Depending on requirement variables can be modified. Following environment variable must be edited.

* ssh_public_key

For more detailed instructions review main.tf

Author: Simo Vilmunen 16/12/2018 

*/

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}


# Variables to create compartments for Demo

variable "compartment_name" { default = "demo-three-instances" }
variable "compartment_description" { default = "Compartment for demoing three instances" }

# Variables to create Tag Namespace

variable "tags" {
  type = "map"
  default = {
    "DemoTagNamespace.Environment" = "poc"
    "DemoTagNamespace.Owner"       = "Me"
  }
}
variable "tag_names" { default = ["Environment", "Owner"] }

variable "tag_namespace_description" { default = "Tag namespace for all resources" }
variable "tag_namespace_name" { default = "DemoTagNamespace" }
variable "is_retired" { default = "false" }

variable "tag_description" { default = ["Environment purpose", "Owner for resource"] }

# IGW variables
variable "internet_gateway_enabled" { default = "true" }
variable "internet_gateway_display_name" { default = "MyIGW" }

variable "igw_route_table_rules_cidr_block" { default = "0.0.0.0/0" }

# VCN variables

variable "vcn_cidr_block" { default = "172.27.0.0/16" }
variable "vcn_display_name" { default = "MyVCN" }
variable "vcn_dns_label" { default = "demo" }

variable "route_table_display_name" {
  default = "MyRouteTable"
}

variable "ad_number" {
  default = "0"
}

variable "compartment_display_name" {
  default = "three-instances-poc"
}

variable "vcn_ingress_protocol" {
  default = "all"
}

# Applications security list variables

variable "private_security_list_name" {
  default = "MyPrivateSL"
}

variable "egress_destination" {
  default = "0.0.0.0/0"
}

variable "egress_protocol" {
  default = "all"
}

variable "ingress_source" {
  default = "0.0.0.0/0"
}

variable "ingress_protocol" {
  default = "6"
}

variable "ingress_stateless" {
  default = false
}



# Subnet variables

variable "cidr_block_subnet" {
  default = "172.27.0.0/24"
}

variable "display_name_subnet" {
  default = "poc-subnet"
}

variable "dns_label_subnet" {
  default = "poc"
}



variable "ingress_ports" {
  description = "all the ports for security list"
  default = [
    { minport     = 22
      maxport     = 22
      source_cidr = "0.0.0.0/0"
    },
    { minport     = 0
      maxport     = 0
      source_cidr = "172.27.0.0/16"
  }]
}

// INSTANCE VARIABLES

variable "operating_system" {
  default = "Oracle Linux"
} // Name for the OS

variable "operating_system_version" {
  default = "7.6"
} // OS Version

variable "shape_name" {
  default = "VM.Standard2.1"
} // Shape what to be used. Smallest shape selected by default

variable "source_type" {
  default = "image"
} // What type the image source is

variable "assign_public_ip" {
  default = "true"
} // This is server in public subnet it will have a public IP

variable "instance_variables" {
  description = "Map instance name to hostname"
  default = {
    "ForEach1" = "fe-1"
    "ForEach2" = "fe-2"
    "ForEach3" = "fe-3"
  }
}
variable "instance_create_vnic_details_hostname_label" {
  default = "ForEach"
}

variable "is_monitoring_disabled" {
  default = false
}

variable "ssh_public_key" {
  default = "EDIT ME TO BE REAL SSH KEY"
}

variable "instance_create_vnic_details_skip_source_dest_check" {
  default = false
}
