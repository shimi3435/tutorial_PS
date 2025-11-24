#!/bin/bash

#------- qsub option -----------

###ProjectID###
#PBS -P NIFS25KISC015

#PBS -q B_dev
#PBS -l select=1
#PBS -l walltime=10:00
#PBS -N test_PS
#PBS -j oe

#------- Program execution -----------

export PYENV_VERSION=myenv_3.11.14

cd ${PBS_O_WORKDIR}

python test_PS.py