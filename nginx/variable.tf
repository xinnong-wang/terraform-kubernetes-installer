variable "version" {
  default = "1.13.1"
}

variable "listen_port" {
  default = "6443"
}

variable "hosts" {
  type = "list"
}

variable "count" {
  default = "0"
}

variable "user" {
  default = "opc"
}

variable "private_key" {}
