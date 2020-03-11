#!/usr/bin/env bash

mkdir build
cd build

if [[ "$target_platform" == linux-64 ]]; then
    LDFLAGS="-lrt ${LDFLAGS}"
fi


git clone https://github.com/pybind/pybind11.git
echo pwd
ls
cd pybind11
mkdir build
cd build
cmake \
    -DPYBIND11_TEST=NO \
    -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX \
    -DCMAKE_PREFIX_PATH=$BUILD_PREFIX \
    ..
make install


cmake \
    -DBoost_NO_BOOST_CMAKE=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DAUDI_BUILD_AUDI=no \
    -DAUDI_BUILD_MAIN=no \
    -DAUDI_BUILD_TESTS=no \
    -DAUDI_BUILD_PYAUDI=yes \
    ..

make -j${CPU_COUNT} VERBOSE=1

make install
