package terraform.analysis

import input as tfplan

violation[output] {                                                                 # line 2                                      # line 3
  m1 = tfplan[name]["destination_ranges.#"]
  not cidr_contain(privateIPRanges, m1)
  #x1 = "pub"
  output = {
		"id": "Public",
		"IPaddress": m1,
		"rule_name": tfplan[name]["name"]
  }
}


violation[output] {                                                                 # line 2                                      # line 3
  firewallName = tfplan[name]["name"]
  not re_match("a--[a-zA-Z0-9-]+--to--[a-zA-Z0-9-]+", firewallName)
  #x1 = "private"
  output = {
		"id": "Firewall name does not match",
		"Name": firewallName,
		"rule_name": tfplan[name]["name"]
  }
}



privateIPRanges = {"10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"}



cidr_contain(array, ip) {
	some i
	net.cidr_contains(array[i], ip)
}

not_allow {
    count(violation) >= 1
}
#public IP
#name
#all tcp
#
