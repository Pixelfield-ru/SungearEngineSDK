cmake_minimum_required(VERSION 3.22)

project(SungearEngineSDK)

message("VCPKG_ROOT: " $ENV{VCPKG_ROOT})

if(NOT EXISTS $ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)
    message(FATAL_ERROR "Please specify VCPKG_ROOT. Check that the %VCPKG_ROOT%/scripts/buildsystems/vcpkg.cmake file exists in the VCPKG_ROOT directory. Restart your IDE after specifying VCPKG_ROOT.")
endif()

list(APPEND CMAKE_PREFIX_PATH $ENV{VCPKG_ROOT}/installed/x64-linux/share)
list(APPEND CMAKE_PREFIX_PATH $ENV{VCPKG_ROOT}/installed/x64-linux/include)
list(APPEND CMAKE_PREFIX_PATH $ENV{VCPKG_ROOT}/installed/x64-linux/lib)
list(APPEND CMAKE_MODULE_PATH $ENV{VCPKG_ROOT}/installed/x64-linux/share/stb)

message("CMAKE_PREFIX_PATH: " ${CMAKE_PREFIX_PATH})

set(CMAKE_TOOLCHAIN_FILE $ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)

add_definitions(-DSUNGEAR_DEBUG)
add_definitions(-DBOOST_STACKTRACE_USE_ADDR2LINE)
add_definitions(-DBOOST_STACKTRACE_USE_BACKTRACE)
add_definitions(-DGLM_ENABLE_EXPERIMENTAL)
add_definitions(-DUSE_LIBPNG)
#add_definitions(-DBOOST_STACKTRACE_LINK)
add_definitions(-DHC_NO_COMPRESSION)
add_definitions(-DNOMINMAX)

set(CMAKE_CXX_STANDARD 23)

set(CMAKE_VERBOSE_MAKEFILE ON)

message("ToolChain CMAKE_CXX_LINK_EXECUTABLE: ${CMAKE_CXX_LINK_EXECUTABLE}")

IF(UNIX)
    add_compile_options(-fPIC)
    set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wno-implicit-fallthrough -Wno-ignored-qualifiers -g -rdynamic -fno-pie -no-pie")
    set(CMAKE_CXX_FLAGS_DEBUG "-O1")
    set(CMAKE_CXX_FLAGS_RELEASE "-O3")
elseif(MSVC)
    add_compile_options("$<$<C_COMPILER_ID:MSVC>:/utf-8>")
    add_compile_options("$<$<CXX_COMPILER_ID:MSVC>:/utf-8>")

    set(CompilerFlags
            CMAKE_CXX_FLAGS
            CMAKE_CXX_FLAGS_DEBUG
            CMAKE_CXX_FLAGS_RELEASE
            CMAKE_C_FLAGS
            CMAKE_C_FLAGS_DEBUG
            CMAKE_C_FLAGS_RELEASE
            )
    foreach(CompilerFlag ${CompilerFlags})
        string(REPLACE "/MD" "/MT" ${CompilerFlag} "${${CompilerFlag}}")
    endforeach()

    set(MSVC_RUNTIME "dynamic")
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
    set(BUILD_SHARED_LIBS FALSE)
endif ()

# multiple definition because of bullet library
set(CMAKE_SHARED_LINKER_FLAGS "-Wl,-allow-multiple-definition -Wno-return-type")

# options --------------------------

# TODO: make SG_BUILD_EDITOR
set(SG_BUILD_TESTS OFF)

set(SG_RESOURCES_COPY_MODELS ON)
set(SG_RESOURCES_COPY_SHADERS ON)
set(SG_RESOURCES_COPY_TEXTURES ON)
set(SG_RESOURCES_COPY_UI ON)
set(SG_RESOURCES_COPY_FONTS ON)

# ----------------------------------
add_subdirectory(Externals)
add_subdirectory(Sources)
if(${SG_BUILD_TESTS})
    add_subdirectory(Tests)
endif()

message("Bullet Include Dir: " ${BULLET_INCLUDE_DIR})
message("Bullet Libraries: " ${BULLET_COLLISION_LIBRARY} ", " ${BULLET_DYNAMICS_LIBRARY} ", " ${BULLET_MATH_LIBRARY})

install(FILES "FindSungearEngineSDK.cmake" DESTINATION "share/SungearEngineSDK")

# move all necessary dlls to target exes ------------------

if(EXISTS ${CMAKE_BINARY_DIR}/Externals/Assimp/bin/libassimp-5d.dll)
    file(COPY ${CMAKE_BINARY_DIR}/Externals/Assimp/bin/libassimp-5d.dll DESTINATION ${SG_PHYS_TEST_BIN})
    file(COPY ${CMAKE_BINARY_DIR}/Externals/Assimp/bin/libassimp-5d.dll DESTINATION ${SG_EDITOR_BIN})
endif()

if(MSVC AND EXISTS ${CMAKE_BINARY_DIR}/Externals/Assimp/bin/assimp-vc143-mtd.dll)
    file(COPY ${CMAKE_BINARY_DIR}/Externals/Assimp/bin/assimp-vc143-mtd.dll DESTINATION ${SG_PHYS_TEST_BIN})
    file(COPY ${CMAKE_BINARY_DIR}/Externals/Assimp/bin/assimp-vc143-mtd.dll DESTINATION ${SG_EDITOR_BIN})
endif()

if(EXISTS ${CMAKE_BINARY_DIR}/lib/glfw3d.dll)
    file(COPY ${CMAKE_BINARY_DIR}/lib/glfw3d.dll DESTINATION ${SG_PHYS_TEST_BIN})
    file(COPY ${CMAKE_BINARY_DIR}/lib/glfw3d.dll DESTINATION ${SG_EDITOR_BIN})
endif ()