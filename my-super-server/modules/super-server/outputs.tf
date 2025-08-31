output "public_ip" {
  value = try(twc_floating_ip.fip[0].ip, null)
}
