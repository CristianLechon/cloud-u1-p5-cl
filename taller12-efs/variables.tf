# Archivo de variables: Conjunto de variables que va a definir el usuario en el script
# region donde se desplegaran los recursos
variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "Id de la AMI"
  type        = string
  default     = "ami-0c230065b91270bc6"
}

variable "tipo_instancia" {
  description = "tipo de instancia"
  type        = string
  default     = "t2.micro"
}

variable "nombre_llave" {
  description = "nombre del par de llaves"
  type        = string
  default     = "mi-primera-llaves-ja"

}

variable "cantidad_instancias" {
  description = "Cantidad de intsnacias"
  type        = number
  default     = 2
}
