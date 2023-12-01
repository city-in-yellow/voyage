job "registry" {
  datacenters = ["spicerack"]
  type        = "service"

  group "registry" {
    count = 1
    network {
      port "post" {
        to = 5000
      }
    }

    service {
      name = "registry"
      tags = ["route@registry"]
      port = "post"
      check {
        name     = "alive"
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    task "registry" {
      driver = "docker"
      config {
        image = "registry:latest"
        ports = ["post"]
        volumes = [
          "/mnt/emerald/registry:/data"
        ]
      }
      env {
        REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY = "/data"
      }
    }
  }
}
