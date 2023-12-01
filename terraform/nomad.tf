provider "nomad" {
  address = "http://rosemary:4646"
}

resource "nomad_job" "foundry" {
  jobspec = file("../nomad/foundry.nomad.hcl")
}

resource "nomad_job" "golink" {
  jobspec = file("../nomad/golink.nomad.hcl")
}

resource "nomad_job" "registry" {
  jobspec = file("../nomad/registry.nomad.hcl")
}

data "local_file" "caddyfile" {
  filename = "../docker/caddy/Caddyfile.tmpl"
}

resource "nomad_job" "caddy" {
  jobspec = templatefile("../nomad/caddy.nomad.hcl.tmpl", {
    caddyfile = data.local_file.caddyfile.content
  })
}

# resource "nomad_job" "cat" {
#   jobspec = templatefile("../nomad/cat.nomad.hcl.tmpl", {
#     caddyfile = data.local_file.caddyfile.content
#   })
# }
