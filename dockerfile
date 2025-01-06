FROM ubuntu:22.04

# Install required packages
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y curl git build-essential cmake libtool autotools-dev automake pkg-config python3

# Install vcpkg
RUN git clone https://github.com/microsoft/vcpkg.git /vcpkg
WORKDIR /vcpkg
RUN ./bootstrap-vcpkg.sh
RUN ./vcpkg integrate install

# Copy the project files
WORKDIR /app
COPY . /app

# Run build
RUN chmod +x build.sh
RUN ./build.sh
