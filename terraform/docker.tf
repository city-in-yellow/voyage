provider "docker" {
  host = "unix:///var/run/docker.sock"

  registry_auth {
    address       = "ttl.sh"
    auth_disabled = true
  }
}

# resource "docker_image" "caddy" {
#   name = "ttl.sh/f5664482-fa92-4fd3-966c-7f135014f49d:24h"
#   build {
#     context  = "../docker/caddy"
#     no_cache = true
#   }
#   triggers = {
#     dir_sha1 = sha1(join("", [for f in fileset("../docker/caddy", "*") : filesha1("../docker/caddy/${f}")]))
#   }
# }

# resource "docker_registry_image" "caddy" {
#   name          = docker_image.caddy.name
#   keep_remotely = true
# }
