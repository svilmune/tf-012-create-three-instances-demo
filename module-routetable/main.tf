variable "vcn_id" {}
variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "route_table_route_rules_cidr_block" {}
variable "route_table_display_name" {}
variable "network_id" {}


resource "oci_core_route_table" "CreateRouteTable" {

  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = var.route_table_display_name

  dynamic "route_rules" {

    for_each = zipmap(var.network_id, var.route_table_route_rules_cidr_block)

    content {
      network_entity_id = route_rules.key
      destination       = route_rules.value

    }
  }
}
 