variable "tenancy_ocid" {}
variable "compartment_ocid" {}

variable "tag_namespace_description" {}
variable "tag_namespace_name" {}
variable "is_retired" {}

variable "tag_names" { type = "list" }
variable "tag_description" { type = "list" }




resource "oci_identity_tag_namespace" "CreateTagNamespace" {
  #Required
  compartment_id = var.compartment_ocid
  description    = var.tag_namespace_description
  name           = var.tag_namespace_name

  is_retired = var.is_retired
}

resource "oci_identity_tag" "CreateTag" {
  count            = length(var.tag_names)
  description      = var.tag_description[count.index]
  name             = var.tag_names[count.index]
  tag_namespace_id = oci_identity_tag_namespace.CreateTagNamespace.id

  is_retired = false

}
