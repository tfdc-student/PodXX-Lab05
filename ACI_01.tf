module "aci_tenant_site_01" {
  providers = {
    aci = aci.aci-01
  }

  source      = "qzx/tenant/aci"
  tenant_name = "Pod${local.podNumber}_Tenant_Site_01"
  vrfs        = ["Pod${local.podNumber}_VRF_01", "Pod${local.podNumber}_VRF_02"]

  bridge_domains = {
    BD1 = {
      routing = true
      vrf     = "Pod${local.podNumber}_VRF_01"
    },
    BD2 = {
      routing = false
      vrf     = "Pod${local.podNumber}_VRF_02"
    }
  }

  application_profiles = ["Pod${local.podNumber}_APP_PROF_01", "Pod${local.podNumber}_APP_PROF_02"]
  epgs = {
    EPG1 = {
      name                = "EPG_01"
      application_profile = "Pod${local.podNumber}_APP_PROF_01"
      bridge_domain       = "BD1"
      domains             = ["uni/phys-MY_PHYSICAL_DOMAIN"]
      static_paths = [
        {
          vlan_id = parseint("11${local.podNumber}", 10)
          path    = "topology/pod-1/protpaths-201-202/pathep-[PATH_01]"
        },
        {
          vlan_id = parseint("12${local.podNumber}", 10)
          path    = "topology/pod-1/protpaths-201-202/pathep-[PATH_02]"
        }
      ]
    },
    EPG2 = {
      name                = "EPG_02"
      application_profile = "Pod${local.podNumber}_APP_PROF_02"
      bridge_domain       = "BD2"
      domains             = ["uni/phys-MY_PHYSICAL_DOMAIN"]
      static_paths        = []
    }
  }
}
