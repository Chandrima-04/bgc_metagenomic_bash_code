#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=165:00:00
#SBATCH --mem=750GB
#SBATCH --job-name=spades
#SBATCH --array=0-4
#SBATCH --mail-user=cb4603@nyu.edu
#SBATCH --mail-type=FAIL

source ~/.bashrc
source activate spades

job=/athena/masonlab/scratch/users/chb4004/PhD/Gowanus/data/Core_Samples/jobs
names=($(cat $job))

INPUT_DIR=/athena/masonlab/scratch/users/chb4004/PhD/bgc_datasets/Gowanus/human_read_removal
SAMPLE_NAME=${names[${SLURM_ARRAY_TASK_ID}]}


input_1=$INPUT_DIR/${SAMPLE_NAME}_host_removed_R1.fastq.gz
input_2=$INPUT_DIR/${SAMPLE_NAME}_host_removed_R2.fastq.gz

cd /athena/masonlab/scratch/users/chb4004/PhD/bgc_datasets/Gowanus/spades

OUTPUT_DIR=${PWD}/${SAMPLE_NAME}

if [ -f ${OUTPUT_DIR}/scaffolds.fasta ]; then
    echo "[$SAMPLE_NAME] scaffolds.fasta already exists. Skipping SPAdes."
else
    echo "[$SAMPLE_NAME] scaffolds.fasta not found. Running SPAdes..."
    spades.py --meta --phred-offset 33 -1 $input_1 -2 $input_2 -o ${OUTPUT_DIR} --threads 40
fi


#spades.py --meta --phred-offset 33  -1 $input_1 -2 $input_2 -o ${names[${SLURM_ARRAY_TASK_ID}]}
#spades.py --meta -1 $input_1 -2 $input_2 -o ${names[${SLURM_ARRAY_TASK_ID}]}
#spades.py --meta -1 $input_1 -2 $input_2 -o "DS"
