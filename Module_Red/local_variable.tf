locals {
  nombre_vpc = "vpc-${var.env}-${var.name_vpc}-${var.id_build}"
  #nombre_red_privada      = "net-${var.env}-${var.name_red_priv}-${var.id_build}"
  #nombre_red_publica      = "net-${var.env}-${var.name_red_pub}-${var.id_build}"
  nombre_internet_gateway = "igw-${var.env}-${var.name_internet_gateway}-${var.id_build}"
  nombre_tabla_ruta_pub   = "rt-${var.env}-${var.name_tabla_ruta_pub}-${var.id_build}"
  nombre_tabla_ruta_priv  = "rt-${var.env}-${var.name_tabla_ruta_priv}-${var.id_build}"
  nombre_security_group   = "sgr-${var.env}-${var.name_security_group}-${var.id_build}"

  nombre_default_acl         = "nac-${var.env}-default-${var.id_build}"
  nombre_default_route_table = "rt-${var.env}-default-${var.id_build}"
  nombre_elastic_ip          = "eip-${var.env}-default-${var.id_build}"
  nombre_nat_gateway         = "nat-${var.env}-default-${var.id_build}"

  merged_tags_vpc = merge(var.tags, { Name = local.nombre_vpc })
  #merged_tags_red_priv         = merge(var.tags, { Name = local.nombre_red_privada })
  #merged_tags_red_pub          = merge(var.tags, { Name = local.nombre_red_publica })
  merged_tags_internte_gateway = merge(var.tags, { Name = local.nombre_internet_gateway })
  merged_tags_tabla_ruta_pub   = merge(var.tags, { Name = local.nombre_tabla_ruta_pub })
  merged_tags_tabla_ruta_priv  = merge(var.tags, { Name = local.nombre_tabla_ruta_priv })
  merged_tags_security_group   = merge(var.tags, { Name = local.nombre_security_group })

  merged_tags_default_acl         = merge(var.tags, { Name = local.nombre_default_acl })
  merged_tags_default_route_table = merge(var.tags, { Name = local.nombre_default_route_table })
  merged_tags_elastic_ip          = merge(var.tags, { Name = local.nombre_elastic_ip })
  merged_tags_nat_gateway         = merge(var.tags, { Name = local.nombre_nat_gateway })

  cidr_block_red = substr(var.cidr_block, 0, length(var.cidr_block) - length(split(".", var.cidr_block)[3]))
}
