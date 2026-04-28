#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 1
#SBATCH -t 15:00
#SBATCH -J quast_eval

# Load modules
module load QUAST/5.3.0-gfbf-2024a

# Copy contigs the compute node temp storage
cp /proj/uppmax2026-1-61/nobackup/pilla/assembly/canu_output/canu_pacbio.contigs.fasta $SNIC_TMP

# Move into the temporary directory
cd $SNIC_TMP

# Do evaluation with quast
quast.py canu_pacbio.contigs.fasta


# Copy final output back to project storage
cp -r quast_results /proj/uppmax2026-1-61/nobackup/pilla/assembly
