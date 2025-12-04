#!/bin/bash

#------- qsub option -----------

###ProjectID###
#PBS -P NIFS25KISC015

#PBS -q B_dev
#PBS -l select=1
#PBS -l walltime=10:00
#PBS -N test_JAX_PS
#PBS -j oe

#------- Program execution -----------

#module load rocm/6.3.3
export PYENV_VERSION=myenv_3.10.14
#export LLVM_PATH=/opt/rocm/llvm

cd ${PBS_O_WORKDIR}

python test_JAX_PS.py