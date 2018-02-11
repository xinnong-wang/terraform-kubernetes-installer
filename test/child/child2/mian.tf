variable count {}
resource "null_resource" "example1" {
  count = "${var.count}"
  connection {
    host = "127.0.0.1"
    type     = "ssh"
    port = "2222"
    user     = "vagrant"
    private_key  = "${file("${path.module}/vagrant_private_key")}"
  }
}
