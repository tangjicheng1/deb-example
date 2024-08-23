#!/bin/bash

PACKAGE_NAME="myapp"
VERSION="1.0.0"
ARCHITECTURE="amd64"
MAINTAINER="Your Name <your.email@example.com>"
DESCRIPTION="A simple C++ Hello World application."

BUILD_DIR="${PACKAGE_NAME}_${VERSION}"
DEBIAN_DIR="${BUILD_DIR}/DEBIAN"
BIN_DIR="${BUILD_DIR}/usr/bin"
BINARY_FILE_PATH="./build/myapp"
CONTROL_FILE="${DEBIAN_DIR}/control"

prepare_dirs() {
    mkdir -p "${DEBIAN_DIR}"
    mkdir -p "${BIN_DIR}"
}

copy_binary() {
    if [ ! -f "${BINARY_FILE_PATH}" ]; then
        echo "Error: Binary file not found at ${BINARY_FILE_PATH}. Run the build script first."
        exit 1
    fi
    cp "${BINARY_FILE_PATH}" "${BIN_DIR}/"
}

create_control_file() {
    cat > "${CONTROL_FILE}" <<EOL
Package: ${PACKAGE_NAME}
Version: ${VERSION}
Section: base
Priority: optional
Architecture: ${ARCHITECTURE}
Maintainer: ${MAINTAINER}
Description: ${DESCRIPTION}
EOL
}

build_deb() {
    dpkg-deb --build "${BUILD_DIR}"
}

cleanup() {
    rm -rf "${BUILD_DIR}"
}

main() {
    prepare_dirs
    copy_binary
    create_control_file
    build_deb
    cleanup
    echo "Package ${PACKAGE_NAME}_${VERSION}.deb created successfully."
}

main
