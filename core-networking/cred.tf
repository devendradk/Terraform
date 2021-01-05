provider "google" {
 credentials = "${file("/var/jenkins_home/sa.json")}"
 project     = "prod-test-300819"
 region      = "us-central1"
}
