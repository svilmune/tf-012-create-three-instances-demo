output "security_list_id" { value = "${oci_core_security_list.CreateSecurityList.id}" }

output "securitylist" {
  value = oci_core_security_list.CreateSecurityList
}