# ya no me solicita el ingreso de datos por el usuario, toma los valores por defecto
provider "aws" {
  region = var.region
}

# Creamos el security group
resource "aws_security_group" "mi-sg-efs-instancias" {
  name        = "mi-security-group-terraform-efs-instancias"
  description = "Security Group para mi instancia de terraform"
  vpc_id      = "vpc-0122b2d4ff694cb1f"
  # regla de entrada para SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # regla de salida para HTTP

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = [aws_security_group.mi-sg-efs.id]
  }


}

# Creamos el security group
resource "aws_security_group" "mi-sg-efs" {
  name        = "mi-security-group-terraform-efs"
  description = "Security Group para mi instancia de terraform"
  vpc_id      = "vpc-0122b2d4ff694cb1f"
  # regla de entrada para SSH
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    security_groups = [aws_security_group.mi-sg-efs-instancias.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# Declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_efs" {
  ami             = var.ami_id                          # ID de la imagen
  instance_type   = var.tipo_instancia                  # Tipo de instancia
  key_name        = var.nombre_llave                    # Nombre del par de claves
  security_groups = [aws_security_group.mi-sg-efs-instancias.name] # asignamos el security group a la instancia
  count           = var.cantidad_instancias             # número de instancias
  tags = {
    Name = "Mi instancia EFS - ${count.index + 1}" # Etiqueta para identificar la instancia

  }
  vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancias.id] # Asignamos el security group a la instancia y listo
}
