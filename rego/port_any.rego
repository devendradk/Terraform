package terraform.analysis

import input as tfplan
import data.common

violation[output] {
  #some name
  firewallName = tfplan[name]["name"]
  numberOfPorts := [port |
        tfplan[name][port] = _
        regex.match("allow.[0-9]+.ports.#",port)
    ]

  tfplan[name]["name"] == firewallName
  to_number(tfplan[name][numberOfPorts[_]]) == 0
  output = {
		"id": "TCP OR UDP any port is allowed",
		#"numberOfPorts": concat(",",o),
		"rule_name": tfplan[name]["name"]
  }
}
