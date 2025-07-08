#CREACION DE GRUPOS DE SEGURIDAD
resource "aws_security_group" "sg_instancias" {
  name        = local.nombre_security_group
  description = var.description_security_group
  vpc_id      = aws_vpc.this.id

  dynamic "ingress" {
    for_each = var.list_ingress_port
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = var.list_egress_port
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = local.merged_tags_security_group

  depends_on = [aws_vpc.this]
}

resource "aws_default_network_acl" "default_acl" {
  default_network_acl_id = aws_vpc.this.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = local.merged_tags_default_acl

  depends_on = [aws_vpc.this]
}

resource "aws_default_route_table" "default_rt" {
  default_route_table_id = aws_vpc.this.default_route_table_id

  tags = local.merged_tags_default_route_table

  depends_on = [aws_vpc.this]
}
