variable "compartment_ocid" {}
variable "k8smaster_subnet_0_id" {}
variable "k8smaster_subnet_1_id" {}

variable "label_prefix" {
  default = ""
}
variable "count" {
  default = 1
}

variable "k8sMasterAd1Count" {}

variable "k8sMasterAd2Count" {}

variable "k8sMasterAd3Count" {}

variable "master_lb_enabled" {}

variable "k8smaster_ad1_private_ips" {
  type    = "list"
  default = []
}

variable "k8smaster_ad2_private_ips" {
  type    = "list"
  default = []
}

variable "k8smaster_ad3_private_ips" {
  type    = "list"
  default = []
}

variable "shape" {
  default = "100Mbs"
}

variable "is_private" {
  default = "false"
}
