#!/bin/bash
docker image rm ichte/sshserver -f
docker build -t ichte/sshserver -f Dockerfile .

# docker run --rm -p 2222:22 ichte/sshserver