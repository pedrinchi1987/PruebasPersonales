variable "env" {
  type        = string
  description = "Valor de ambiente"
}

variable "id_build" {
  type        = string
  description = "Identificador de Recurso"
  default     = "01"
}

variable "tags" {
  type        = map(any)
  description = "Tgas a asociar a la politica"
}

variable "name_vpc" {
  type        = string
  description = "Nombre de VPC"
}

variable "name_red_priv" {
  type        = string
  description = "Nombre de Red Privada"
}

variable "name_red_pub" {
  type        = string
  description = "Nombre de Red Publica"
  default     = ""
}

variable "cidr_block" {
  type        = string
  description = "Mascara de Red para VPC"
}

variable "instance_tenancy" {
  type        = string
  description = "Tenancy for VPC"
  default     = "default"
}

variable "cantidad_zonas" {
  type        = number
  description = "Cantidad de Zonas de Disponibilidad a usar"
  default     = 1
}

variable "habilitar_publica" {
  type        = bool
  description = "Habilitar Red Pública"
  default     = false
}

variable "name_internet_gateway" {
  type        = string
  description = "Nombre de Recurso de Salida a Internet"
  default     = ""
}

variable "name_tabla_ruta_priv" {
  type        = string
  description = "Nombre Tabla de Ruta Privada"
  default     = ""
}

variable "name_tabla_ruta_pub" {
  type        = string
  description = "Nombre Tabla de Ruta Publica"
  default     = ""
}

variable "name_security_group" {
  type        = string
  description = "Nombre de Grupo de Seguridad"
}

variable "description_security_group" {
  type        = string
  description = "Descripcion de Grupo de Seguridad"
  default     = "Descripcion de Grupo de Seguridad"
}

variable "list_ingress_port" {
  type        = list(string)
  description = "Listado de Puertos de Ingreso"
  default     = []
}

variable "list_egress_port" {
  type        = list(string)
  description = "Listado de Puertos de Egreso"
  default     = []
}

variable "add_elastic_ip" {
  type        = bool
  description = "Decide agregar ip elastica"
  default     = false
}

variable "enable_dns_support" {
  type        = bool
  description = "Habilitar DNS Soporte"
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Habilitar DNS Hostnames"
  default     = false
}
