docker run -d -p 127.0.0.1:${port}:${port} -v /etc/nginx:/etc/nginx --name nginx-proxy --restart=on-failure nginx:${version}
