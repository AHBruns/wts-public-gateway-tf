variable "subnet_ids" {
  type = set(string)
}

variable "vpc_id" {
  type = string
}

variable "availability_zones" {
  type = set(string)
}