terraform {
  required_version = ">= 1.2.0"

  required_providers {
    oci = {
      source                = "oracle/oci"
      version               = ">= 4.80.0"
      configuration_aliases = [oci.home]
    }
  }
}

module "lz" {
  source = "../config"

  region                    = var.region
  tenancy_ocid              = var.tenancy_ocid
  use_enclosing_compartment = false
  # existing_enclosing_compartment_ocid = "ocid1.compartment.oc1..aaaaaaaach4vwr7x2vhj4pnz3yolnsjwsoj4a7eflsuz42dgznfb5ctsjbfa"
  env_advanced_options           = true
  policies_in_root_compartment   = "CREATE"
  vcn_cidrs                      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  exacs_vcn_cidrs                = []
  hub_spoke_architecture         = true
  hs_advanced_options            = true
  dmz_vcn_cidr                   = "10.0.0.0/24"
  public_src_bastion_cidrs       = []
  public_src_lbr_cidrs           = []
  public_dst_cidrs               = []
  network_admin_email_endpoints  = ["example@example.com"]
  security_admin_email_endpoints = ["example@example.com"]
  enable_cloud_guard             = false
  service_label                  = "seblz01"
}
