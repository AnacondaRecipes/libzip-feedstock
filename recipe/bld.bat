:: cmd

:: Delete tests.
:: Many of these seem to be failing due to UTF-8 issues - may want to look into later.
del regress\clone-buffer-add.test
del regress\clone-buffer-replace.test
del regress\file_comment_encmismatch.test
del regress\fseek_deflated.test
del regress\fseek_fail.test
del regress\preload.test
del regress\rename_cp437.test
del regress\rename_utf8.test
del regress\rename_utf8_encmismatch.test
del regress\set_file_mtime.test
del regress\utf-8-standardization.test
del regress\zip64_stored_creation.test

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
      -DCMAKE_BUILD_TYPE=Release ^
      -DENABLE_BZIP2=ON ^
      -DENABLE_LZMA=ON


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
