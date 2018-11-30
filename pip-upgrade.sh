#!/bin/bash
# Upgrades all pip packages for the user (not system wide)
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U --user
