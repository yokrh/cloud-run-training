variable "gcp_project" {}
variable "gcp_region" {}
variable "gcp_account_json" {}
variable "cloud_run_name" {}
variable "container_image" {}
variable "cloud_storage_location" {}
variable "cloud_storage_name" {}


provider "google" {
  credentials = "${file(var.gcp_account_json)}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}

resource "google_cloud_run_service" "default" {
  name     = "tftest-cloudrun"
  location = "${var.gcp_region}"

  metadata {
    namespace = "${var.gcp_project}"
  }

  template {
    spec {
      containers {
        image = "gcr.io/scenefinder/hello-cloud-run"
        # env {
        #   name = "TARGET"
        #   value = "hogehoge"
        # }
      }
    }
  }
}

output "cloud_run__name" {
  value = "${google_cloud_run_service.default.name}"
}

## debug
# resource "google_storage_bucket" "default" {
#   name     = "${var.cloud_storage_name}"
#   location = "${var.cloud_storage_location}"
# }

# output "cloud_storage_name" {
#   value = "${google_storage_bucket.default.name}"
# }
