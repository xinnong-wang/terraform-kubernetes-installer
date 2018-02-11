
module "nginx-lb" {
  source           = "./nginx"
  count            = "${var.master_lb_enabled=="true"? 0 : 1 }"
  hosts             = "${list("h13", "h2")}"
}


module "child" {
  source           = "./child"
  count = 2
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
