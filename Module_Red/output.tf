output "vpc" {
  value = aws_vpc.this
}

output "red_privada" {
  value = aws_subnet.red_privada
}

output "red_publica" {
  value = aws_subnet.red_publica
}

output "grupo_seguridad" {
  value = aws_security_group.sg_instancias
}
