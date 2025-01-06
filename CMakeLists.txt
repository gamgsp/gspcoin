cmake_minimum_required(VERSION 3.15)
project(gspcoin)

# Enable modern c++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Set the vcpkg toolchain file
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake)

# Define source files
file(GLOB_RECURSE GSPCOIN_SOURCES src/*.cpp src/*.h)

# Add dependencies using find_package (you'll need to add more)
find_package(Boost CONFIG REQUIRED COMPONENTS system filesystem thread)  # Example Boost
find_package(OpenSSL CONFIG REQUIRED) # Example OpenSSL
find_package(libevent CONFIG REQUIRED)  # Example libevent

# Add gmp
find_package(GMP CONFIG REQUIRED) # Example GMP

# Add libzmq
find_package(libzmq CONFIG REQUIRED)

# Add bls
find_package(bls-dash CONFIG REQUIRED)

# Add miniupnpc
find_package(miniupnpc CONFIG REQUIRED)

# Create executable
add_executable(gspcoind ${GSPCOIN_SOURCES})

# Link with libraries
target_link_libraries(gspcoind PRIVATE Boost::boost  OpenSSL::Crypto OpenSSL::SSL libevent::libevent GMP::gmp libzmq::libzmq bls-dash::bls-dash miniupnpc::miniupnpc)

# Add installation support
install(TARGETS gspcoind DESTINATION bin)

# Add CMAKE_INSTALL_PREFIX for better install path management
set(CMAKE_INSTALL_PREFIX ${CMAKE_BINARY_DIR}/install CACHE PATH "Installation path")
