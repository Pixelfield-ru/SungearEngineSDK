vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Pixelfield-ru/SungearEngineSDK
        REF "${VERSION}"
        SHA512 f12148eeda9cd529a6bf20cba44b99de28b1dfc48af625e81bd22bb1f81e2de4605d0cf4d7dd1be35fba8b85e9337de39bf8f6ad97fd1a0caaad37d8255447b4
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
