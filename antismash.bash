#!/bin/sh

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=160:00:00
#SBATCH --mem=150GB
#SBATCH --job-name=AntiSMASH
#SBATCH --array=11-249
#SBATCH --mail-user=cb4603@nyu.edu
#SBATCH --mail-type=FAIL

job=/athena/masonlab/scratch/users/chb4004/PhD/bgc_datasets/tara/data/job
names=($(cat $job))
input=/athena/masonlab/scratch/users/chb4004/PhD/bgc_datasets/tara/spades/${names[${SLURM_ARRAY_TASK_ID}]}/scaffolds.fasta
ls -ld  $input

cd /athena/masonlab/scratch/users/chb4004/PhD/bgc_datasets/tara/antismash7
work_dir=${names[${SLURM_ARRAY_TASK_ID}]}

source ~/.bashrc
source activate antismash

if [ -f ${work_dir}/index.html ]; then
    echo "[$SAMPLE_NAME] index.html already exists. Skipping AntiSMASH."
else
    echo "[$SAMPLE_NAME] index.html not found. Running AntiSMASH..."

    rm -rf ${work_dir}
    mkdir -p ${work_dir}

    antismash --output-dir ${work_dir} \
        --genefinding-tool prodigal \
        --taxon bacteria \
        --cc-mibig \
        --tigrfam \
        --cb-general \
        --asf \
        --smcog-trees \
        --cb-knownclusters \
        --cb-subclusters \
        --pfam2go \
        $input
fi
