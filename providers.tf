terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
    }
  }
}

locals {
  aci_password = "ENTER PASSWORD PROVIDED BY THE INSTRUCTOR"
  podNumber    = "ENTER POD NUMBER, IF BELOW 10 IN 0X FORMAT"
  aci_url_01   = "https://172.16.0.11"
  aci_url_02   = "https://172.16.0.12"
  username     = "admin"
  insecure     = true
}

provider "aci" {
  alias = "aci-01"
  # cisco-aci user name
  username = local.username
  # cisco-aci password
  password = local.aci_password
  # cisco-aci url
  url      = local.aci_url_01
  insecure = local.insecure
}

provider "aci" {
  alias = "aci-02"
  # cisco-aci user name
  username = local.username
  # cisco-aci password
  password = local.aci_password
  # cisco-aci url
  url      = local.aci_url_02
  insecure = local.insecure
}


