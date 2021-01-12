package terraform.analysis

import input as tfplan
import data.common

violation[output] {                                                                 
  firewallName = tfplan[name]["name"]
  numberOfPorts := [port |
        tfplan[name][port] = _
        regex.match("allow.[0-9]+.ports.#",port)
    ]

  tfplan[name]["name"] == firewallName
  to_number(tfplan[name][numberOfPorts[_]]) > 2
  output = {
		"id": "Adding more than 2 ports needs extra review",
		"numberOfPorts": to_number(tfplan[name][numberOfPorts[_]]),
		"rule_name": tfplan[name]["name"]
  }
}
