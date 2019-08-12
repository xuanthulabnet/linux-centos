#!/bin/bash
docker image rm ichte/samba -f
docker build -t ichte/samba -f Dockerfile .