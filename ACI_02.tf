module "aci_tenant_site_02" {
  providers = {
    aci = aci.aci-02
  }

  source      = "qzx/tenant/aci"
  tenant_name = "Pod${local.podNumber}_Tenant_Site_02"
  vrfs        = ["Pod${local.podNumber}_VRF"]
  bridge_domains = {
    BD1 = {
      routing = true
      vrf     = "Pod${local.podNumber}_VRF"
    }
  }
  application_profiles = ["Pod${local.podNumber}_APP_PROF"]
  epgs = {
    EPG1 = {
      name                = "EPG_1"
      application_profile = "Pod${local.podNumber}_APP_PROF"
      bridge_domain       = "BD1"
      domains             = ["uni/phys-MY_PHYSICAL_DOMAIN"]
      static_paths = [
        {
          vlan_id = parseint("20${local.podNumber}", 10)
          path    = "topology/pod-1/protpaths-201-202/pathep-[PATH_A]"
        }
      ]
    }
  }
}
