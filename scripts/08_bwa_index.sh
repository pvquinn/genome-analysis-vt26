#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 1
#SBATCH -t 02:00:00
#SBATCH -J bwa_index

# Load BWA
module load BWA/0.7.19-GCCcore-13.3.0

# Path to your genome FASTA
GENOME=/proj/uppmax2026-1-61/nobackup/pilla/synteny/ncbi_dataset/data/GCF_009734005.1/GCF_009734005.1_ASM973400v2_genomic.fna

# Copy genome to node-local storage
cp $GENOME $SNIC_TMP/

# Move into node-local storage
cd $SNIC_TMP

# Run BWA index
bwa index $(basename $GENOME)

# Create output directory
mkdir -p /proj/uppmax2026-1-61/nobackup/pilla/RNA/genome_index

# Copy index files back
cp $(basename $GENOME)* /proj/uppmax2026-1-61/nobackup/pilla/RNA/genome_index/
