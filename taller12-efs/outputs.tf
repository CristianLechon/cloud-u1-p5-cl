# Lo que yo quiero imprimir en consola como salida

output "ids_instancias" {
    description = "id de las instancias creadas"
    value = aws_instance.mi_instancia_efs[*].id
}

#value = aws_instance.mi_instancia_efs.count
output "cantidad_instancias" {
  description = "Cantidad de instancias creadas"
  value = length(aws_instance.mi_instancia_efs)
}

output "ip_public_instancias" {
  description = "IPs publicas de las instancias creadas"
  value = aws_instance.mi_instancia_efs[*].public_ip
}

output "zonas_disponibilidad" {
  description = "Zonas de disponibilidad de las instancias creadas"
  value = aws_instance.mi_instancia_efs[*].availability_zone
}