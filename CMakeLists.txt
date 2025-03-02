cmake_minimum_required(VERSION 3.10)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(MSVC)
    set(CMAKE_GENERATOR_TOOLSET "ClangCL")
endif(MSVC)

project(_tmap)

if(MSVC)
    # set(CMAKE_CXX_FLAGS_DEBUG "/O2 /permissive /std:c++17")
    # set(CMAKE_CXX_FLAGS_RELEASE "/O2 /permissive /std:c++17 /wd4068 /wd4305 /wd4267 /wd4244")
else()
    set(CMAKE_CXX_FLAGS_DEBUG "-O2 -fopenmp")
    set(CMAKE_CXX_FLAGS_RELEASE "-O2 -fopenmp")
endif(MSVC)


if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    SET(OGDF_INCLUDE "/usr/local/include")
    SET(OGDF_LIB "/usr/local/lib")

    include_directories(${OGDF_INCLUDE})
    link_directories(${OGDF_LIB})
elseif(WIN32)
    SET(OGDF_INCLUDE "C:/ogdf/include")
    SET(OGDF_LIB "C:/ogdf/lib")

    include_directories(${OGDF_INCLUDE})
    link_directories(${OGDF_LIB})
else()
    SET(OGDF_INCLUDE "/include")
    SET(OGDF_LIB "/lib")

    include_directories(${OGDF_INCLUDE})
    link_directories(${OGDF_LIB})
endif()

find_package(OpenMP REQUIRED)

set(THREADS_PREFER_PTHREAD_FLAG ON)

find_package(Threads REQUIRED)

SET(SOURCE_DIR "src/_tmap")
# Tell cmake that headers are in alse in source_dir
include_directories(${SOURCE_DIR})
SET(SOURCES "${SOURCE_DIR}/layout.cc" "${SOURCE_DIR}/lshforest.cc" "${SOURCE_DIR}/minhash.cc" "${SOURCE_DIR}/analyse.cc")

# Generate python module
add_subdirectory(pybind11)

pybind11_add_module(_tmap ${SOURCES} "${SOURCE_DIR}/bindings.cc")
if(MSVC)
target_link_libraries(_tmap PRIVATE OGDF.lib COIN.lib)
else()
target_link_libraries(_tmap PRIVATE OGDF COIN)
endif(MSVC)

target_link_libraries(_tmap PRIVATE Threads::Threads)
target_link_libraries(_tmap PRIVATE ${OpenMP_CXX_FLAGS})
