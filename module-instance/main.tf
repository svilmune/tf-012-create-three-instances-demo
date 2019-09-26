variable "compartment_id" {}
variable "instance_availability_domain" {}
variable "shape_id" {}
variable "image_id" {}
variable "subnet_id" {}
variable "ssh_public_key" {}
variable "assign_public_ip" {}
variable "instance_variables" { type = "map" }
variable "instance_create_vnic_details_hostname_label" {}
variable "instance_create_vnic_details_skip_source_dest_check" {}




resource "oci_core_instance" "CreateInstance" {
  for_each            = var.instance_variables
  availability_domain = var.instance_availability_domain
  compartment_id      = var.compartment_id
  shape               = var.shape_id
  source_details {
    source_id   = var.image_id
    source_type = "image"
  }

  create_vnic_details {
    subnet_id              = var.subnet_id
    display_name           = each.key
    hostname_label         = each.value
    skip_source_dest_check = var.instance_create_vnic_details_skip_source_dest_check
    assign_public_ip       = var.assign_public_ip
  }



  metadata = {
    ssh_authorized_keys = var.ssh_public_key
    #		user_data = "${base64encode(file(var.bootstrapfile))}"
  }
  subnet_id    = var.subnet_id
  display_name = each.key
}