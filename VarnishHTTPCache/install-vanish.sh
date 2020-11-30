#!/bin/bash

yum install -y epel-release
yum install varnish -y
systemctl start varnish
systemctl enable varnish
systemctl status varnish
