locals {
  use_timeweb = lower(var.cloud) == "timeweb"
  use_aws     = lower(var.cloud) == "aws"
}

data "twc_os" "selected" {
  count   = local.use_timeweb ? 1 : 0
  name    = var.os.name
  version = var.os.version
}

data "twc_configurator" "cfg" {
  count    = local.use_timeweb ? 1 : 0
  location = var.location
}

resource "twc_server" "this" {
  count = local.use_timeweb ? 1 : 0

  name  = var.name
  os_id = data.twc_os.selected[0].id

  configuration {
    configurator_id = data.twc_configurator.cfg[0].id
    cpu             = var.cpu
    ram             = var.ram_mb
    disk            = 1024 * var.disk_gb
  }

  availability_zone = var.availability_zone
}

resource "twc_floating_ip" "fip" {
  count             = local.use_timeweb ? 1 : 0
  availability_zone = var.availability_zone
  comment           = "fip for ${var.name}"

  resource {
    type = "server"
    id   = twc_server.this[0].id
  }

  ddos_guard = false
}

resource "null_resource" "aws_placeholder" {
  count = local.use_aws ? 1 : 0
}
