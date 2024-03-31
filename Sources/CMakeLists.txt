add_definitions(-DSTB_IMAGE_IMPLEMENTATION)

add_subdirectory(SGUtils)
add_subdirectory(SGCore)
add_subdirectory(SGConsole)

# installing targets
install(TARGETS SGUtils SGCore SGConsoleAPI SGConsoleApp)

#installing headers
file(GLOB_RECURSE SGCONSOLEAPI_HEADERS SGConsole/API/*.h)
file(GLOB_RECURSE SGCONSOLEAPP_HEADERS SGConsole/App/*.h)
file(GLOB_RECURSE SGCORE_HEADERS SGCore/*.h)
file(GLOB_RECURSE SGUTILS_HEADERS SGUtils/*.h)

install(FILES SGCONSOLEAPI_HEADERS SGCONSOLEAPP_HEADERS SGCORE_HEADERS SGUTILS_HEADERS)