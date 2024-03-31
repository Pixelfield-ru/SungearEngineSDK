vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Pixelfield-ru/SungearEngineSDK
        REF "${VERSION}"
        SHA512 33458eec218e00f217a6fbdb6eb84297c70b49b4f481016d6d6b1252aa34ac01e19f625f73cf98f75d62f041cbe35c9967bd2fe0fcd95f4558b029f32297cd39
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
