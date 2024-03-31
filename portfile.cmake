vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)

set(VCPKG_BUILD_TYPE release)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO Pixelfield-ru/SungearEngineSDK
        REF "${VERSION}"
        SHA512 6bd7fa6f6b0c785898e41edfac9c5134cf58b3f6a72bbd433da22d03116334a70a25d804391f9c2c214a4cc22517ec39ff814e62e1dabade74bb46381759c453
        HEAD_REF main
)

vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}"
        OPTIONS
        -DCMAKE_BUILD_TYPE=release
)

vcpkg_cmake_install()

#vcpkg_cmake_config_fixup(PACKAGE_NAME "sungearengine")
vcpkg_cmake_config_fixup(CONFIG_PATH share/sungearengine-sdk)
vcpkg_fixup_pkgconfig()
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
# file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

#[[file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)]]
