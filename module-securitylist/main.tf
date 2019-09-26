variable "vcn_id" {}
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "sl_display_name" {}
variable "egress_destination" {}
variable "egress_protocol" {}
variable "ingress_source" {}
variable "ingress_stateless" {}
variable "ingress_ports" {}
variable "ingress_protocol" {}



resource "oci_core_security_list" "CreateSecurityList" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = var.sl_display_name
  // Protocol options are supported only for ICMP ("1"), TCP ("6"), and UDP ("17")
  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = var.egress_destination
    protocol    = var.egress_protocol
  }
  dynamic "ingress_security_rules" {
    iterator = port
    for_each = [for y in var.ingress_ports : {
      minport     = y.minport
      maxport     = y.maxport
      source_cidr = y.source_cidr
    }]
    content {
      protocol  = var.ingress_protocol
      source    = port.value.source_cidr
      stateless = var.ingress_stateless
      tcp_options {
        // These values correspond to the destination port range.
        min = port.value.minport
        max = port.value.maxport
      }
    }
  }
}

