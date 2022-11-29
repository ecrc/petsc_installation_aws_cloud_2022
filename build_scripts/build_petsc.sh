#!/bin/bash

# Dependecies include:
# -  Intel => 2019
# -  Openmpi-4.1.x built with Intel compiler
# -  Valgrind for memory debugging
# -  Cmake => 3.17
#

## PETSc build

# Define the `PETSC_DIR` environment variable to the target intallation path

export PETSC_DIR=~/petsc

# Clone git repository

git clone -b v3.17.4 https://gitlab.com/petsc/petsc.git $PETSC_DIR


#Build with optimization

cd $PETSC_DIR
export PETSC_ARCH=arch-opt
CFGFLAGS=(
    --COPTFLAGS=-O3 -march=native -mtune=native
    --CXXOPTFLAGS=-O3 -march=native -mtune=native
    --FOPTFLAGS=-O3 -march=native -mtune=native
    --download-metis-cmake-arguments=-DCMAKE_C_COMPILER_FORCED=1
    --download-metis=1
    --download-p4est=1
    --download-parmetis-cmake-arguments=-DCMAKE_C_COMPILER_FORCED=1
    --download-parmetis=1
    --known-64-bit-blas-indices=0
    --known-mpi-c-double-complex=1
    --known-mpi-int64_t=1
    --known-mpi-long-double=1
    --known-sdot-returns-double=1
    --known-snrm2-returns-double=1
    --with-64-bit-indices=1
    --with-batch=1
    --with-cc=mpicc
    --with-cxx=mpicxx
    --with-debugging=0
    --with-dependencies=0
    --with-fc=mpif90
    --with-fortran-bindings=0
    --with-precision=double
    --with-scalar-type=real
    --with-zlib=1
)
./configure "${CFGFLAGS[@]}"
make
make check

