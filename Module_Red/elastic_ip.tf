resource "aws_eip" "this" {
  count  = var.add_elastic_ip ? 1 : 0
  domain = "vpc"
  tags   = local.merged_tags_elastic_ip
}
