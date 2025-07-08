
module "Red" {
  source                     = "./Module_Red"
  env                        = var.env
  name_vpc                   = "principal"
  cidr_block                 = "66.66.0.0/26"
  name_red_priv              = "private"
  name_red_pub               = "public"
  cantidad_zonas             = local.cantidad_zonas
  habilitar_publica          = local.habilitar_publica
  name_internet_gateway      = "out-net"
  name_tabla_ruta_priv       = "private-net"
  name_tabla_ruta_pub        = "public-net"
  name_security_group        = "instances"
  description_security_group = "Grupo de Seguridad para Instancias"
  list_ingress_port          = ["80", "443", "22", "3306", "3307"]
  list_egress_port           = ["0"]
  add_elastic_ip             = local.add_elastic_ip
  enable_dns_support         = true
  enable_dns_hostnames       = true

  tags = {
    Ambiente = upper(var.env)
  }
}
