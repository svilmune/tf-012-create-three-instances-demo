provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

data "oci_core_images" "oraclelinux" {

  compartment_id           = var.tenancy_ocid
  operating_system         = var.operating_system
  operating_system_version = var.operating_system_version

  # exclude GPU specific images
  filter {
    name   = "display_name"
    values = ["^([a-zA-z]+)-([a-zA-z]+)-([\\.0-9]+)-([\\.0-9-]+)$"]
    regex  = true
  }
}

data "oci_identity_availability_domains" "GetAds" {
  compartment_id = var.tenancy_ocid
}

module "CreateCompartment" {
  source                  = "./module-compartment"
  tenancy_ocid            = var.tenancy_ocid
  compartment_name        = var.compartment_name
  compartment_description = var.compartment_description
}


# Create base VCN - there will be only one VCN
module "CreateVCN" {
  source           = "./module-vcn"
  compartment_ocid = module.CreateCompartment.compartment.id
  vcn_cidr_block   = var.vcn_cidr_block
  display_name     = var.vcn_display_name
  dns_label        = var.vcn_dns_label
}

# Create IGW
module "CreateIGW" {
  source                        = "./module-igw"
  compartment_ocid              = module.CreateCompartment.compartment.id
  vcn_id                        = module.CreateVCN.vcn.id
  internet_gateway_enabled      = var.internet_gateway_enabled
  internet_gateway_display_name = var.internet_gateway_display_name
}

# Create Route Table
module "CreateRouteRule" {

  source                             = "./module-routetable"
  tenancy_ocid                       = var.tenancy_ocid
  compartment_ocid                   = module.CreateCompartment.compartment.id
  vcn_id                             = module.CreateVCN.vcn.id
  network_id                         = [module.CreateIGW.internetgateway.id]
  route_table_display_name           = var.route_table_display_name
  route_table_route_rules_cidr_block = [var.igw_route_table_rules_cidr_block]

}

# Create Security List
module "CreatePrivateSecurityListPOC" {
  source             = "./module-securitylist"
  compartment_ocid   = module.CreateCompartment.compartment.id
  vcn_id             = module.CreateVCN.vcn.id
  tenancy_ocid       = var.tenancy_ocid
  sl_display_name    = var.private_security_list_name
  egress_destination = var.egress_destination
  egress_protocol    = var.egress_protocol
  ingress_protocol   = var.ingress_protocol
  ingress_source     = var.ingress_source
  ingress_stateless  = var.ingress_stateless
  ingress_ports      = var.ingress_ports
}

# Create Subnet
module "CreateSubnetPOC" {
  source                       = "./module-subnet"
  availability_domain          = lookup(data.oci_identity_availability_domains.GetAds.availability_domains[0], "name")
  vcn_id                       = module.CreateVCN.vcn.id
  compartment_ocid             = module.CreateCompartment.compartment.id
  vcn_default_security_list_id = [module.CreatePrivateSecurityListPOC.securitylist.id]
  vcn_default_route_table_id   = module.CreateRouteRule.routetable.id
  vcn_default_dhcp_options_id  = module.CreateVCN.vcn.default_dhcp_options_id
  sub_cidr_block               = var.cidr_block_subnet
  sub_display_name             = var.display_name_subnet
  sub_dns_label                = var.dns_label_subnet
  tenancy_ocid                 = var.tenancy_ocid
  prohibit_public_ip_on_vnic   = "false" # Set to true for private subnet
}

# Create Three instances 

module "CreateInstances" {
  source                       = "./module-instance"
  compartment_id               = module.CreateCompartment.compartment.id
  instance_availability_domain = lookup(data.oci_identity_availability_domains.GetAds.availability_domains[0], "name")
  subnet_id                    = module.CreateSubnetPOC.subnet.id
  image_id                     = lookup(data.oci_core_images.oraclelinux.images[0], "id")
  shape_id                     = var.shape_name
  ssh_public_key               = var.ssh_public_key
  assign_public_ip             = var.assign_public_ip


  instance_create_vnic_details_hostname_label         = var.instance_create_vnic_details_hostname_label
  instance_create_vnic_details_skip_source_dest_check = var.instance_create_vnic_details_skip_source_dest_check

  instance_variables = var.instance_variables
}
