#!/bin/bash


# Isolate the build.
mkdir -p Build
cd Build || exit 1


# Generate the build files.
echo "Generating the build files."
cmake .. ${CMAKE_ARGS} \
      -GNinja \
      -DCMAKE_PREFIX_PATH=$PREFIX \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DENABLE_COMMONCRYPTO=OFF \
      -DENABLE_GNUTLS=OFF \
      -DENABLE_MBEDTLS=OFF \
      -DENABLE_OPENSSL=ON \
      -DENABLE_WINDOWS_CRYPTO=OFF \
      -DENABLE_BZIP2=ON \
      -DENABLE_LZMA=OFF \
      -DENABLE_ZSTD=OFF \
      -DCMAKE_BUILD_TYPE=Release


# Build.
echo "Building..."
ninja || exit 1


# Perform tests.
echo "Testing..."
ninja test || exit 1
#  path_to/test || exit 1
#  ctest -VV --output-on-failure || exit 1


# Installing
echo "Installing..."
ninja install || exit 1


# Error free exit!
echo "Error free exit!"
exit 0
