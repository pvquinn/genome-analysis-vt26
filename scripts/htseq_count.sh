#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -c 1
#SBATCH -t 07:00:00
#SBATCH -J htseq_count

module load HTSeq/2.1.2-gfbf-2024a

ALIGN_DIR=/proj/uppmax2026-1-61/nobackup/pilla/RNA/aligned
GTF=/proj/uppmax2026-1-61/nobackup/pilla/RNA/genomic.gtf
OUT_DIR=/proj/uppmax2026-1-61/nobackup/pilla/RNA/counts

mkdir -p $OUT_DIR

# Copy GTF to node-local storage
cp $GTF $SNIC_TMP/
cd $SNIC_TMP/

for BAM in $ALIGN_DIR/*.sorted.bam
do
    SAMPLE=$(basename $BAM .sorted.bam)

    echo "Counting features for: $SAMPLE"

    # Copy BAM + index to node-local storage
    cp $BAM $BAM.bai $SNIC_TMP/

    htseq-count \
        --format=bam \
        --order=pos \
        --stranded=no \
        --type=gene \
        --idattr=gene_id \
        ${SAMPLE}.sorted.bam genomic.gtf \
        > ${SAMPLE}.counts.txt

    # Copy results back to project directory
    cp ${SAMPLE}.counts.txt $OUT_DIR/
done
