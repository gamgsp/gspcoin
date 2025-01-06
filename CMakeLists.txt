cmake_minimum_required(VERSION 3.15)  # Ensure minimum CMake version
project(gspcoin)                     # Project Name

# Enable modern c++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Define source files (you'll need to expand this later)
file(GLOB_RECURSE GSPCOIN_SOURCES src/*.cpp src/*.h)

# Create executable
add_executable(gspcoind ${GSPCOIN_SOURCES})

# Add installation support
install(TARGETS gspcoind DESTINATION bin)

# Add CMAKE_INSTALL_PREFIX for better install path management
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install CACHE PATH "Installation path")
