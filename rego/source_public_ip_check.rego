package terraform.analysis

import input as tfplan
import data.common

violation[output] {                                                                 
   firewallName = tfplan[name]["name"]
    all := [port |
        tfplan[name][port] = _
        regex.match("source_ranges.[0-9]+",port)
    ]

  some j
  tfplan[name]["name"] == firewallName
  not cidr_contain(common.privateIPRanges, tfplan[name][all[j]])

  output := {
        "id": "source public IPs are not allowed",
  		"source IPaddress": tfplan[name][all[j]],
  		"rule_name": tfplan[name]["name"]
  }
}

cidr_contain(array, ip) {
	net.cidr_contains(array[_], ip)
}
