#!/bin/bash

# Build the container image
podman build -t fuas:name-only-$(date +%Y%m%d-%H%M%Z) -f name-only.Dockerfile .

# Purge the intermediary images
podman rmi `podman images --filter label=builder=true -q`
