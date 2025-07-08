#CREACION DE VPC
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = local.merged_tags_vpc
}

#CREACION DE REDES
resource "aws_subnet" "red_privada" {
  count             = var.cantidad_zonas
  vpc_id            = aws_vpc.this.id
  availability_zone = data.aws_availability_zones.zona_habilitada.names[count.index]
  cidr_block        = "${local.cidr_block_red}${0 + (count.index * 16)}/28"

  tags = merge(var.tags, { Name = "net-${var.env}-${var.name_red_priv}-${format("%02s", count.index + 1)}" })

  depends_on = [aws_vpc.this]
}

resource "aws_subnet" "red_publica" {
  count             = var.habilitar_publica ? var.cantidad_zonas : 0
  vpc_id            = aws_vpc.this.id
  availability_zone = data.aws_availability_zones.zona_habilitada.names[count.index]
  cidr_block        = "${local.cidr_block_red}${(var.cantidad_zonas * 16) + (count.index * 16)}/28"

  tags = merge(var.tags, { Name = "net-${var.env}-${var.name_red_pub}-${format("%02s", count.index + 1)}" })

  depends_on = [aws_vpc.this]
}

#CREACION DE INTERNET GATEWAY
resource "aws_internet_gateway" "ig_red_publica" {
  count  = var.habilitar_publica ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = local.merged_tags_internte_gateway

  depends_on = [aws_vpc.this]
}

#CREACION DE TABLAS DE RUTAS
resource "aws_route_table" "tabla_ruta_red_publica" {
  count  = var.habilitar_publica ? 1 : 0
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_red_publica[0].id
  }

  tags = local.merged_tags_tabla_ruta_pub

  depends_on = [
    aws_vpc.this,
    aws_internet_gateway.ig_red_publica
  ]
}

resource "aws_route_table_association" "asociacion_ruta_publica" {
  count          = var.habilitar_publica ? var.cantidad_zonas : 0
  route_table_id = aws_route_table.tabla_ruta_red_publica[0].id
  subnet_id      = aws_subnet.red_publica[count.index].id

  depends_on = [
    aws_subnet.red_publica,
    aws_route_table.tabla_ruta_red_publica
  ]
}

resource "aws_route_table" "tabla_ruta_red_privada" {
  vpc_id = aws_vpc.this.id

  dynamic "route" {
    for_each = var.add_elastic_ip ? [0] : []
    content {

      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.this[0].id
    }
  }

  tags = local.merged_tags_tabla_ruta_priv

  depends_on = [
    aws_vpc.this
  ]
}

resource "aws_route_table_association" "asociacion_ruta_privada" {
  count          = var.cantidad_zonas
  route_table_id = aws_route_table.tabla_ruta_red_privada.id
  subnet_id      = aws_subnet.red_privada[count.index].id

  depends_on = [
    aws_subnet.red_privada,
    aws_route_table.tabla_ruta_red_privada
  ]
}
