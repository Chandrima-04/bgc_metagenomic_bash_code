#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --time=48:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=Trim-Galore
#SBATCH --array=0-31
#SBATCH --mail-user=cb4603@nyu.edu
#SBATCH --mail-type=FAIL

source ~/.bashrc
source activate trim_gallore

#Job file consists all file name 
job=/athena/masonlab/scratch/users/chb4004/PhD/Gowanus/data/Timeseries/Gowanus_Dec2014_Apr2015/jobs
names=($(cat $job))

#Input location
input1=/athena/masonlab/scratch/users/chb4004/PhD/Gowanus/data/Timeseries/Gowanus_Dec2014_Apr2015/${names[${SLURM_ARRAY_TASK_ID}]}_R1_001.fastq.gz
input2=/athena/masonlab/scratch/users/chb4004/PhD/Gowanus/data/Timeseries/Gowanus_Dec2014_Apr2015/${names[${SLURM_ARRAY_TASK_ID}]}_R2_001.fastq.gz

ls -ld $input1 $input2

cd /athena/masonlab/scratch/users/chb4004/PhD/bgc_datasets/Gowanus/trim-gallore

trim_galore --paired $input1 $input2
