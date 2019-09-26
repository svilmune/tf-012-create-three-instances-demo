variable "vcn_id" {}
variable "compartment_ocid" {}
variable "internet_gateway_display_name" {}
variable "internet_gateway_enabled" {}

resource "oci_core_internet_gateway" "CreateIGW" {
  compartment_id = var.compartment_ocid
  enabled        = var.internet_gateway_enabled
  vcn_id         = var.vcn_id
  display_name   = var.internet_gateway_display_name
}
