#!/bin/bash
sudo docker run -p 127.0.0.1:6443:6443 -v ~/nginx:/etc/nginx --name nginx-proxy --restart=on-failure nginx:1.13.1