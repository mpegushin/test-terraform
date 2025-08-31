variable "cloud" {
  type    = string
  default = "timeweb"
}

variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "os" {
  type = object({
    name    = string
    version = string
  })
  default = {
    name    = "ubuntu"
    version = "22.04"
  }
}

variable "cpu" {
  type    = number
  default = 1
}

variable "ram_mb" {
  type    = number
  default = 2048
}

variable "disk_gb" {
  type    = number
  default = 20
}
