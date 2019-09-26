output "igw_id" { value = "${oci_core_internet_gateway.CreateIGW.id}" }

output "internetgateway" {
  value = oci_core_internet_gateway.CreateIGW
}