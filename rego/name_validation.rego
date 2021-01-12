package terraform.analysis

import input as tfplan
import data.common

violation[output] {                                                               
  firewallName = tfplan[name]["name"]
  not re_match("a--[a-zA-Z0-9-]+--to--[a-zA-Z0-9-]+", firewallName)
  output = {
		"id": "Firewall name does not match standard",
		"Name": firewallName,
		"rule_name": tfplan[name]["name"]
  }
}