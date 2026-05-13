#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 1
#SBATCH -t 04:00:00
#SBATCH -J bwa_align

# Load modules
module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# Paths
INDEX_DIR=/proj/uppmax2026-1-61/nobackup/pilla/RNA/genome_index
TRIM_DIR=/proj/uppmax2026-1-61/nobackup/pilla/RNA/trimmed
OUT_DIR=/proj/uppmax2026-1-61/nobackup/pilla/RNA/aligned

mkdir -p $OUT_DIR

# Copy genome index to node-local storage
cp $INDEX_DIR/* $SNIC_TMP/
cd $SNIC_TMP/

# Loop over all paired trimmed FASTQ files
for R1 in $TRIM_DIR/*_1_paired.fastq.gz
do
    SAMPLE=$(basename $R1 _1_paired.fastq.gz)
    R2=${TRIM_DIR}/${SAMPLE}_2_paired.fastq.gz

    echo "Aligning sample: $SAMPLE"

    # Copy FASTQs to node-local storage
    cp $R1 $R2 $SNIC_TMP/

    # Align with BWA-MEM
    bwa mem -t 1 GCF_009734005.1_ASM973400v2_genomic.fna \
        ${SAMPLE}_1_paired.fastq.gz ${SAMPLE}_2_paired.fastq.gz \
        | samtools view -bS - \
        | samtools sort -o ${SAMPLE}.sorted.bam

    # Index BAM
    samtools index ${SAMPLE}.sorted.bam

    # Copy results back to project directory
    cp ${SAMPLE}.sorted.bam ${SAMPLE}.sorted.bam.bai $OUT_DIR/
done
