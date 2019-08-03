#!/usr/bin/env bash

yarn_packages=(
    npx
    serve
)

for package in "${yarn_packages[@]}"
do
   yarn global add $package
done
