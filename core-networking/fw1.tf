resource "google_compute_firewall" "a_a_to_b" {
  name     = "a--a-app--to--b-app"
  network  = "default"
  project  = "prod-test-300819"
  priority = 951

  allow {
    protocol = "tcp"

    ports = [
      "3301-3428",
    ]
  }

  source_tags = [
    "a-servers",
  ]

  target_tags = [
    "b-servers",
  ]
}
