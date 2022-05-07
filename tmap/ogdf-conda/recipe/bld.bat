md build
cd build

REM MSBUILD version
msbuild -version

REM cmake .. -DCMAKE_GENERATOR="Visual Studio 14" -DCMAKE_GENERATOR_PLATFORM=x64 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=%PREFIX%
cmake .. -DCMAKE_GENERATOR="Visual Studio 16 2019" -DCMAKE_GENERATOR_PLATFORM=x64 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=%PREFIX%
REM -DCMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG=%PREFIX%
REM -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=%PREFIX% 
REM -DBUILD_SHARED_LIBS=ON

REM REM Make sure that msbuild is in the PATH and its version matches the compiler's

REM REM For some reason, tmap doesn't build when ogdf is built with the Release config
cmake --build . --config Release --target install -- /m

@REM robocopy "Release" "%LIBRARY_BIN%" *.dll /E
@REM robocopy "Release" "%PREFIX%" *.dll /E

@REM robocopy "Release" "%LIBRARY_BIN%" *.pdb /E
@REM robocopy "Release" "%PREFIX%" *.pdb /E



REM robocopy "%RECIPE_DIR%\windows\include" "%PREFIX%\include" /S /E

REM robocopy "%RECIPE_DIR%\windows" "%PREFIX%\lib" *.lib /E

REM robocopy "%RECIPE_DIR%\windows" "%LIBRARY_BIN%" *.dll /E
REM robocopy "%RECIPE_DIR%\windows" "%PREFIX%" *.dll /E

REM robocopy "%RECIPE_DIR%\windows" "%LIBRARY_BIN%" *.pdb /E
REM robocopy "%RECIPE_DIR%\windows" "%PREFIX%" *.pdb /E

if %ERRORLEVEL% LSS 8 exit 0