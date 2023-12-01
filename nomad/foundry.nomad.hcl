job "foundry" {
  datacenters = ["spicerack"]
  type        = "service"

  group "foundry" {
    count = 1
    network {
      port "http" {
        to = 30000
      }
    }

    service {
      name = "foundry"
      port = "http"
      check {
        name     = "alive"
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
      meta {
        route = "btl"
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    task "foundry" {
      driver = "docker"
      config {
        image = "felddy/foundryvtt:latest"
        ports = ["http"]
        volumes = [
          "/mnt/emerald/foundry:/data"
        ]
      }
      env {}
    }
  }
}
