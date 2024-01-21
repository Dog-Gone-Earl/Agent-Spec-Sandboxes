#!/bin/bash

if [[ $(arch) == "arm64" ]]; then
  echo "Running VAGRANT_VAGRANTFILE=Vagrantfile.arm64 vagrant $1"
  VAGRANT_VAGRANTFILE=Vagrantfile.arm64 vagrant $1
else
  echo "Running VAGRANT_VAGRANTFILE=Vagrantfile.intel vagrant $1"
  VAGRANT_VAGRANTFILE=Vagrantfile.intel vagrant $1
fi