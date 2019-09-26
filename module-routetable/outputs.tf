
output "routetable_id" { value = "${oci_core_route_table.CreateRouteTable.id}" }

output "routetable" {
  value = oci_core_route_table.CreateRouteTable
}