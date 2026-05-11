#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 1
#SBATCH -t 5:00:00
#SBATCH -J trimmomatic
#SBATCH -o trimmomatic_%j.out
#SBATCH -e trimmomatic_%j.err

# Load module
module load Trimmomatic/0.39-Java-17

# Copy raw reads to compute node
cp /proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/transcriptomics_data/RNA-Seq_BH/raw/*.fastq.gz $SNIC_TMP
cp /proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/transcriptomics_data/RNA-Seq_Serum/raw/*.fastq.gz $SNIC_TMP

cd $SNIC_TMP

mkdir -p trimmed

# BH samples
#for sample in ERR1797972 ERR1797973 ERR1797974; do
#    trimmomatic PE \
#        -threads 1 \
#        ${sample}_1.fastq.gz ${sample}_2.fastq.gz \
#        trimmed/${sample}_1_paired.fastq.gz trimmed/${sample}_1_unpaired.fastq.gz \
#        trimmed/${sample}_2_paired.fastq.gz trimmed/${sample}_2_unpaired.fastq.gz \
#        ILLUMINACLIP:/sw/arch/eb/software/Trimmomatic/0.39-Java-17/adapters/TruSeq3-PE.fa:2:30:10 \
#        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
#done

# Serum samples
for sample in ERR1797969 ERR1797970 ERR1797971; do
    trimmomatic PE \
        -threads 1 \
        ${sample}_1.fastq.gz ${sample}_2.fastq.gz \
        trimmed/${sample}_1_paired.fastq.gz trimmed/${sample}_1_unpaired.fastq.gz \
        trimmed/${sample}_2_paired.fastq.gz trimmed/${sample}_2_unpaired.fastq.gz \
        ILLUMINACLIP:/sw/arch/eb/software/Trimmomatic/0.39-Java-17/adapters/TruSeq3-PE.fa:2:30:10 \
        LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done

# Copy results back
cp -r trimmed /proj/uppmax2026-1-61/nobackup/pilla/RNA
