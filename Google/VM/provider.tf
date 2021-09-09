provider "google" {
  region = var.vm_config["region"]
  zone   = var.vm_config["zone"]
}


resource "google_compute_instance" "vm_instance" {
  name         = var.vm_config["instance_name"]
  machine_type = var.vm_config["machine_type"]
  boot_disk {
    initialize_params {
      image = var.vm_config["image"]
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
  labels = var.labels
  tags   = [var.vm_config["network_tags"]]
}

resource "google_compute_firewall" "allow-http" {
  name    = var.vm_config["firewall_name"]
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80", "22"]
  }
  source_tags = [var.vm_config["network_tags"]]
}

variable "vm_config" {
  type = map(any)
  default = {
    region        = "us-central1"
    zone          = "us-central1-c"
    instance_name = "terraform-instance"
    machine_type  = "f1-micro"
    image         = "debian-cloud/debian-9"
    firewall_name = "fw-allow-http"
    network_tags  = "webserver"
  }
}

variable "labels" {
  type = map(any)
  default = {
    name    = "db"
    env     = "dev"
    team    = "devops"
    quarter = "first"
    builtby = "me"
  }
}

