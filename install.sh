#!/bin/sh

if command -v clang
then
	C_COMPILER=clang
else
	C_COMPILER=gcc
fi

if command -v clang++
then
	CXX_COMPILER=clang++
else
	CXX_COMPILER=g++
fi

if command -v ld.lld
then
	FLAGS="-fuse-ld=lld"
else
	FLAGS=""
fi

if test -f "/usr/lib/libc++.so.1"
then
	CXX_FLAGS="-stdlib=libc++"
else
	CXX_FLAGS=""
fi

git clone https://github.com/CalebHeydon/libfreenect2
cd libfreenect2
./install-dep.sh

mkdir build
cd build
cmake \
	-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_C_COMPILER=$C_COMPILER \
	-DCMAKE_CXX_COMPILER=$CXX_COMPILER \
	-DCMAKE_C_FLAGS="$FLAGS" \
	-DCMAKE_CXX_FLAGS="$FLAGS $CXX_FLAGS" \
	-DENABLE_CUDA=OFF \
	-DENABLE_OPENGL=ON \
	..
make
sudo make install
