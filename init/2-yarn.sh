#!/usr/bin/env bash

yarn_packages=(
    npm-check-updates
    npx
    serve
)

for package in "${yarn_packages[@]}"
do
   yarn global add $package
done
