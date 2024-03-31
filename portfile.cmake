vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Pixelfield-ru/SungearEngineSDK
        REF "${VERSION}"
        SHA512 106c5f09b1ff95f90a9b981404c4d5682ec0a5dec3222d8027fc7a19c936efb581038a7235fad6a9e932e947053e1d9a11a229370245fa448be62dbf131e47db
        HEAD_REF main
)

vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}"
        OPTIONS
        -DCMAKE_BUILD_TYPE=Release
)

vcpkg_cmake_install()

#vcpkg_cmake_config_fixup(PACKAGE_NAME "sungearengine")
#vcpkg_cmake_config_fixup(CONFIG_PATH bin/cmake/sungearengine)
vcpkg_fixup_pkgconfig()
vcpkg_cmake_config_fixup()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
# file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

#[[file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)]]
