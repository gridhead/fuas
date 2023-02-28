#!/bin/bash

black --line-length=100 fuas/
isort --profile=black fuas/
flake8 --max-line-length=100 fuas/
