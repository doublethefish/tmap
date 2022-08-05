All packages were collected by the author through this script - https://github.com/reymond-group/tmap/blob/master/azure-pipelines.yml

## Pre-requsites:
- cmake
  - Ensure cmake is uptodate and matches your libomp version
  - on osx this is `brew install libomp cmake` (you can verifiy with `brew info libomp`)
- libomp
- clang

## Build

Either:
* `cd <path-to-tmap>`
* `python3 -m pip install .`
or
* `python3 -m pip install <path-to-tmap>`

## Test

The test method of the assembled package is to run the script
https://github.com/reymond-group/tmap/blob/master/tmap/tests/test_layout.py

Line 19 should work -### it is critical. If you debug and have error on this
line - check previous errors. If still wrong - good luck.

