#!/usr/bin/env bash

# script to run TAPscan classify (including hmmsearch) on all fasta files in a folder.

for i in *.fa
do

NAME=$(basename $i .fa)

echo "Running HMMsearch for $NAME\n"
# run HMMEr search
hmmsearch --domtblout $NAME.domtblout --cut_ga ../domains_v12.txt $i

echo "Running TAPscan Classify for $NAME\n"
# run TAPscan script
../tapscan_classify.pl $NAME.domtblout ../rules_v81.txt $NAME.output.1 $NAME.output.2 $NAME.output.3 ../coverage_values_v10.txt

done

echo "Done!"
