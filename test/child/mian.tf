variable count {}

resource "null_resource" "example2" {
  count = "${var.count}"
  connection {
    host = "127.0.0.1"
    type     = "ssh"
    port = "2222"
    user     = "vagrant"
    private_key  = "${file("${path.module}/vagrant_private_key")}"
  }
}
output "out_list" {
  value = "${var.count>0?element(concat(null_resource.example2.*.id, list("")), 0):"1333"}"
}

output "out1" {
  value = "${null_resource.example2.*.id}"
}

module "child2" {
  source           = "./child2"
  count = 1
}