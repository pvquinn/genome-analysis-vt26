#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 1
#SBATCH -t 30:00
#SBATCH -J trimmed_fastqc

# Load modules
module load FastQC/0.12.1-Java-17

# Copy raw reads to the compute node temp storage
cp /proj/uppmax2026-1-61/nobackup/pilla/RNA/trimmed/*_paired.fastq.gz $SNIC_TMP

# Move into the temporary directory
cd $SNIC_TMP

# Make output directory
mkdir -p fastqc_trimmed

# Do evaluation with fastqc
fastqc -o fastqc_trimmed *_paired.fastq.gz


# Copy final output back to project storage
cp -r fastqc_trimmed /proj/uppmax2026-1-61/nobackup/pilla/RNA

