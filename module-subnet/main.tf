variable "vcn_id" {}
variable "vcn_default_security_list_id" { type = list }
variable "vcn_default_route_table_id" {}
variable "vcn_default_dhcp_options_id" {}
variable "sub_cidr_block" {}
variable "sub_display_name" {}
variable "sub_dns_label" {}
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "prohibit_public_ip_on_vnic" { default = "false" }

variable "availability_domain" {}

resource "oci_core_subnet" "CreateSubnet" {
  availability_domain        = var.availability_domain
  cidr_block                 = var.sub_cidr_block
  display_name               = var.sub_display_name
  dns_label                  = var.sub_dns_label
  compartment_id             = var.compartment_ocid
  vcn_id                     = var.vcn_id
  security_list_ids          = var.vcn_default_security_list_id
  route_table_id             = var.vcn_default_route_table_id
  dhcp_options_id            = var.vcn_default_dhcp_options_id
  prohibit_public_ip_on_vnic = var.prohibit_public_ip_on_vnic
}
