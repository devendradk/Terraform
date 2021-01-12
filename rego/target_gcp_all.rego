package terraform.analysis

import input as tfplan
import data.common

violation[output] {                                
  not tfplan[name]["target_tags.#"]
  output := {
		"id": "GCP All.",
		"rule_name": tfplan[name]["name"]
  }
}