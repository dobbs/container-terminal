backend "consul" {
  address = "consul:8500"
  path = "vault"
}

listener "tcp" {
  address = "vault:8200"
  tls_disable = 1
}

# telemetry {
#   statsite_address = "vault:8125"
#   disable_hostname = true
# }
