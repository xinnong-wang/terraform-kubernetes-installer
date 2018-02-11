# module "nginx-lb" {
#   source      = "../nginx"
#   count       = "${var.master_lb_enabled=="true"? 0 : 1 }"
#   hosts       = "${list("h13", "h2")}"
#   private_key = "dd"
# }

module "child" {
  source = "./child"
  count  = 2
}

output "out1" {
  value = ["${module.child.out1}"]
}

output "out3" {
  value = "${module.child.out_list}"
}

variable "v" {
  default = "2"
}

locals {
  instance_ids = "${var.v=="1"?"v":"vv"}"
}

output "out4" {
  value = "${local.instance_ids}"
}

variable "network_cidrs1" {
  type = "map"
  default = {
    VCN-CIDR          = "10.0.0.0/16"
    PublicSubnetAD1   = "10.0.10.0/24"
    PublicSubnetAD2   = "10.0.11.0/24"
    PublicSubnetAD3   = "10.0.12.0/24"
    etcdSubnetAD1     = "10.0.20.0/24"
    etcdSubnetAD2     = "10.0.21.0/24"
    etcdSubnetAD3     = "10.0.22.0/24"
    masterSubnetAD1   = "10.0.30.0/24"
    masterSubnetAD2   = "10.0.31.0/24"
    masterSubnetAD3   = "10.0.32.0/24"
    workerSubnetAD1   = "10.0.40.0/24"
    workerSubnetAD2   = "10.0.41.0/24"
    workerSubnetAD3   = "10.0.42.0/24"
    k8sCCMLBSubnetAD1 = "10.0.50.0/24"
    k8sCCMLBSubnetAD2 = "10.0.51.0/24"
    k8sCCMLBSubnetAD3 = "10.0.52.0/24"
  }
}

output "private_ip1" {
    value     = "${cidrhost(lookup(var.network_cidrs1,"etcdSubnetAD1"), 0)}"
}
output "private_ip2" {
    value     = "${cidrhost(lookup(var.network_cidrs1,"etcdSubnetAD1"), 1)}"
}