#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 4
#SBATCH -t 03:00:00
#SBATCH -J canu_assembly

# Load modules
module load canu/2.3-GCCcore-13.3.0-Java-17
module load SAMtools/1.22.1-GCC-13.3.0

# Copy all PacBio reads into the compute node temp storage
cp /proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/PacBio/m131*.subreads.fastq.gz $SNIC_TMP

# Move into the temporary directory
cd $SNIC_TMP

# Do Canu assembly
canu \
-p canu_pacbio \
-d canu_output \
genomeSize=3m \
useGrid=false \
maxThreads=4 \
-pacbio *.subreads.fastq.gz

# Copy final output back to project storage
cp -r canu_output /proj/uppmax2026-1-61/nobackup/pilla/assembly
