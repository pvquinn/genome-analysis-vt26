# This script is for evaluating the quality of the RNA-seq alignment with samtools flagstat.

module load SAMtools/1.22.1-GCC-13.3.0

for f in *.bam; do
    samtools flagstat "$f" > "${f%.bam}_flagstat.txt"
done

for f in *.sorted_flagstat.txt; do
    echo "===== $f =====" >> combined_flagstat.txt
    cat "$f" >> combined_flagstat.txt
    echo "" >> combined_flagstat.txt
done
