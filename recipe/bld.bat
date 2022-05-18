:: cmd

:: Isolate the build.
mkdir Build
cd Build
if errorlevel 1 exit /b 1


:: Generate the build files.
echo "Generating the build files."
cmake .. %CMAKE_ARGS% ^
      -G"Ninja" ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DENABLE_COMMONCRYPTO=OFF ^
      -DENABLE_GNUTLS=OFF ^
      -DENABLE_MBEDTLS=OFF ^
      -DENABLE_OPENSSL=ON ^
      -DENABLE_WINDOWS_CRYPTO=OFF ^
      -DENABLE_BZIP2=ON ^
      -DENABLE_LZMA=ON ^
      -DENABLE_ZSTD=ON ^
      -DCMAKE_BUILD_TYPE=Release ^


:: Build.
echo "Building..."
ninja
if errorlevel 1 exit /b 1


:: Perform tests.
echo "Testing..."
ninja test
::  path_to\test
::  ctest -VV --output-on-failure
::  if errorlevel 1 exit /b 1


:: Install.
echo "Installing..."
ninja install
if errorlevel 1 exit /b 1


:: Error free exit.
echo "Error free exit!"
exit 0
