#!/bin/bash

# Build the container image
podman build -t fuas:actv-push-$(date +%Y%m%d-%H%M%Z) -f actv-push.Dockerfile .

# Purge the intermediary images
podman rmi `podman images --filter label=builder=true -q`
