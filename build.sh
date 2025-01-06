#!/bin/bash

# Create build directory if it does not exists
mkdir -p build

# Go inside build directory
cd build

# Run cmake to configure the project
cmake ..

# Compile the project
make -j$(nproc)

# Install the binary in the install directory inside the build folder
make install
