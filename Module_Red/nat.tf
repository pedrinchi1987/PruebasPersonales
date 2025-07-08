resource "aws_nat_gateway" "this" {
  count         = var.habilitar_publica && var.add_elastic_ip ? 1 : 0
  allocation_id = aws_eip.this[0].id
  subnet_id     = aws_subnet.red_publica[count.index].id

  tags = local.merged_tags_nat_gateway

  depends_on = [
    aws_internet_gateway.ig_red_publica,
    aws_eip.this,
    aws_subnet.red_privada
  ]
}
