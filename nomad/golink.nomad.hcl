job "golink" {
  datacenters = ["spicerack"]
  type        = "service"

  group "golink" {
    count = 1

    service {
      name = "golink"
    }

    restart {
      attempts = 2
      interval = "30m"
      delay    = "15s"
      mode     = "fail"
    }

    task "golink" {
      driver = "docker"
      config {
        image = "ghcr.io/tailscale/golink:main"
        args = [
          "--sqlitedb", "/home/nonroot/golink.db",
          "--verbose"
        ]
        volumes = [
          "/mnt/emerald/golink:/home/nonroot"
        ]
      }
    }
  }
}
