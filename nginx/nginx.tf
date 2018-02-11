resource "null_resource" "install" {
  count = "${var.count}"
  connection {
    host = "${element(var.hosts, count.index)}" 
    type     = "ssh"
    user     = "${var.user}"
    private_key  = "${var.private_key}"
  }

  provisioner "file" {
    destination      = "/tmp/setup.sh"
    content = "${data.template_file.nginx_conf.rendered}"
  }
  provisioner "remote-exec" {
    inline = ["echo \"${data.template_file.setup.rendered}\"",
    "cat /tmp/setup.sh"]
  }
}
