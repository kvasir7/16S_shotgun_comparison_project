#modified from https://telatin.github.io/microbiome-bioinformatics//Host-removal/

DB=/data/db/kraken2/rana_temporaria
DIR=/data/workshop/reads/
OUT=~/nohost

mkdir -p "$OUT/"

for R1 in $DIR/Sample*_R1.fq.gz;
    do
        sample=$(basename ${R1%_R1.fq.gz})
        R2=${R1%_R1.fq.gz}_R2.fq.gz
        echo "removing host contamination from" $sample
        echo "Read1:" $R1
        echo "Read2:" $R2
    kraken2 \
        --db $DB \
        --threads 8 \
        --confidence 0.5 \
        --minimum-base-quality 22 \
        --report $OUT/${sample}.report \
        --unclassified-out $OUT/${sample}#.fq > $OUT/${sample}.txt \
        --paired $R1 $R2

    pigz ${OUT}/*.fq
done
