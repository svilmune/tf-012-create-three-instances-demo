variable "tenancy_ocid" {}
variable "compartment_description" {}
variable "compartment_name" {}



resource "oci_identity_compartment" "CreateCompartment" {

  compartment_id = var.tenancy_ocid
  description    = var.compartment_description
  name           = var.compartment_name

}


