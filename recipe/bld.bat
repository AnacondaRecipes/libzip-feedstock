@echo on
mkdir build
if errorlevel 1 exit /B 1
cd build
if errorlevel 1 exit /B 1

cmake -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=STRING:RELEASE ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    ..
if errorlevel 1 exit /B 1

cmake --build . --target INSTALL --config Release
if errorlevel 1 exit /B 1
