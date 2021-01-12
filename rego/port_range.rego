package terraform.analysis

import input as tfplan

violation[output] {
  firewallName = tfplan[name]["name"]
  Ports := [port |
        tfplan[name][port] = _
        regex.match("allow.[0-9]+.ports.[0-9]+",port)
    ]


  some j
  tfplan[name]["name"] == firewallName
  regex.match("[0-9]+-[0-9]+",tfplan[name][Ports[j]])

  output = {
		"id": "Adding port range needs extra review",
		"rule_name": tfplan[name]["name"]
  }
}