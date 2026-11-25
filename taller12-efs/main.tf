# ya no me solicita el ingreso de datos por el usuario, toma los valores por defecto
provider "aws" {
  region = var.region
}

# Se crea sin reglas, para evitar dependencia ciclica.

# Creamos el security group
resource "aws_security_group" "mi-sg-efs-instancias-14" {
  name        = "mi-security-group-terraform-efs-instancias"
  description = "Security Group para mi instancia de terraform"
  vpc_id      = "vpc-0122b2d4ff694cb1f"
  # regla de entrada para SSH
}

# Creamos el security group
resource "aws_security_group" "mi-sg-efs-14" {
  name        = "mi-security-group-terraform-efs"
  description = "Security Group para mi instancia de terraform"
  vpc_id      = "vpc-0122b2d4ff694cb1f"
  # regla de entrada para SSH
}


# Reglas SG-intancias
# Existe un recurso especifico
# Entrada
# Entrada SSH
resource "aws_vpc_security_group_ingress_rule" "entrada_ssh_instancias" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

# Salida
# Salida a EFS 2049
resource "aws_vpc_security_group_egress_rule" "salida_efs" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol       = "tcp"
  from_port         = 2049
  to_port           = 2049
  # Defino el destino
  referenced_security_group_id = aws_security_group.mi-sg-efs-14.id
}

# Salida a internet All traffic
resource "aws_vpc_security_group_egress_rule" "salida_internet" {
  security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

# Reglas SG-EFS
# Entrada
# Regla de entrada EFS 2049
resource "aws_vpc_security_group_ingress_rule" "entrada_efs" {
  security_group_id = aws_security_group.mi-sg-efs-14.id
  ip_protocol       = "tcp"
  from_port         = 2049
  to_port           = 2049
  # Defino el origen
  referenced_security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
}

# Salida
# No se requiere el 


# Declaracion de los recursos de AWS
#resource "aws_instance" "mi_instancia_efs" {
#  ami             = var.ami_id                                     # ID de la imagen
#  instance_type   = var.tipo_instancia                             # Tipo de instancia
#  key_name        = var.nombre_llave                               # Nombre del par de claves
#  security_groups = [aws_security_group.mi-sg-efs-instancias.name] # asignamos el security group a la instancia
#  count           = var.cantidad_instancias                        # número de instancias
#  tags = {
#    Name = "Mi instancia EFS - ${count.index + 1}" # Etiqueta para identificar la instancia
#
#  }
#  vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancias.id] # Asignamos el security group a la instancia y listo
#}
