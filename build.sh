#!/bin/bash

# 创建 build 目录并进入
mkdir -p build
cd build

# 编译 C++ 程序
g++ ../src/main.cpp -o myapp

# 检查编译是否成功
if [ $? -eq 0 ]; then
    echo "Build succeeded."
else
    echo "Build failed."
    exit 1
fi
