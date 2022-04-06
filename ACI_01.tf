module "aci_tenant_site_01" {
  providers = {
    aci = aci.aci-01
  }

  source      = "qzx/tenant/aci"
  tenant_name = "Pod${local.podNumber}_Tenant_Site_01"
  vrfs        = ["Pod${local.podNumber}-VRF-01", "Pod${local.podNumber}-VRF-02"]

  bridge_domains = {
    BD1 = {
      routing = true
      vrf     = "Pod${local.podNumber}-VRF-01"
    },
    BD2 = {
      routing = false
      vrf     = "Pod${local.podNumber}-VRF-02"
    }
  }

  application_profiles = ["Pod${local.podNumber}-APP-PROF-01", "Pod${local.podNumber}-APP-PROF-02"]
  epgs = {
    EPG1 = {
      name                = "EPG-01"
      application_profile = "APP_PROFILE_ONE"
      bridge_domain       = "BD1"
      domains             = ["uni/phys-MY_PHYSICAL_DOMAIN"]
      static_paths = [
        {
          vlan_id = parseint("11${local.podNumber}", 10)
          path    = "topology/pod-1/protpaths-201-202/pathep-[PATH-01]"
        },
        {
          vlan_id = parseint("12${local.podNumber}", 10)
          path    = "topology/pod-1/protpaths-201-202/pathep-[PATH-02]"
        }
      ]
    },
    EPG2 = {
      name                = "EPG-02"
      application_profile = "APP_PROFILE_TWO"
      bridge_domain       = "BD2"
      domains             = ["uni/phys-MY_PHYSICAL_DOMAIN"]
      static_paths        = []
    }
  }
}
