data "template_file" "nginx_conf" {
  template = "${file("${path.module}/nginx.conf")}"

  vars {
    servers = "${join("\n", formatlist("        server %s:443;", var.hosts))}"
    port    = "${var.listen_port}"
  }
}

data "template_file" "setup" {
  template = "${file("${path.module}/setup.sh")}"

  vars {
    version = "${var.version}"
    port    = "${var.listen_port}"
  }
}
