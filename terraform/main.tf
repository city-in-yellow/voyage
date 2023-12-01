terraform {
  backend "consul" {
    path = "terraform/state/voyage"
    lock = true
  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}
