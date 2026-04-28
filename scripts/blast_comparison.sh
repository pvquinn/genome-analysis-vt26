# Load module
module load BLAST+/2.17.0-GCC-13.3.0

# Make blast database
makeblastdb -in /proj/uppmax2026-1-61/nobackup/pilla/synteny/ncbi_dataset/data/GCF_009734005.1/GCF_009734005.1_ASM973400v2_genomic.fna -dbtype nucl -out /proj/uppmax2026-1-61/nobackup/pilla/synteny/blast_db/Efaecium_db

# Run blast
blastn \
  -query /proj/uppmax2026-1-61/nobackup/pilla/assembly/prokka_output/PROKKA_04212026.ffn \
  -db /proj/uppmax2026-1-61/nobackup/pilla/synteny/blast_db/Efaecium_db \
  -outfmt 6 \
  -evalue 1e-5 \
  -max_target_seqs 5 \
  -out /proj/uppmax2026-1-61/nobackup/pilla/synteny/blast_synteny_v2.tsv

