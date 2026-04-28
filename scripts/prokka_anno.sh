#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 1
#SBATCH -t 15:00
#SBATCH -J prokka_annotation

# Load modules
module load prokka/1.14.5-gompi-2024a

# Copy contigs the compute node temp storage
cp /proj/uppmax2026-1-61/nobackup/pilla/assembly/canu_output/canu_pacbio.contigs.fasta $SNIC_TMP

# Move into the temporary directory
cd $SNIC_TMP

# Do annotations with prokka
prokka \
--outdir prokka_output \
canu_pacbio.contigs.fasta


# Copy final output back to project storage
cp -r prokka_output /proj/uppmax2026-1-61/nobackup/pilla/assembly
