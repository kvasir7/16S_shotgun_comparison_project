#modified from https://telatin.github.io/microbiome-bioinformatics//Host-removal/

DB=/home/joe/Documents/NSF_Fellowship/16S_Shotgun_Comparison_Study/Shotgun_Raw/rana_temporaria_DB
DIR=/home/joe/Documents/NSF_Fellowship/16S_Shotgun_Comparison_Study/Shotgun_Raw/16S_comparison
OUT=/home/joe/Documents/NSF_Fellowship/16S_Shotgun_Comparison_Study/Shotgun_Raw/norana_output

mkdir -p "$OUT/"

for R1 in $DIR/*_R1_001.fasta.gz;
    do
        sample=$(basename ${R1%_R1_001.fasta.gz})
        R2=${R1%_R1_001.fasta.gz}_R2.fasta.gz
        echo "removing host contamination from" $sample
        echo "Read1:" $R1

    kraken2 \
        --db $DB \
        --threads 8 \
        --confidence 0.5 \
        --minimum-base-quality 22 \
        --report $OUT/${sample}.report \
        --unclassified-out $OUT/${sample}#.fasta > $OUT/${sample}.txt \
        --paired $R1 $R2

    pigz ${OUT}/*.fasta
done
