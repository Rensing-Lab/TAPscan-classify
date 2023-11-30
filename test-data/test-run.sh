#!/usr/bin/env bash

# script to run TAPscan classify (including hmmsearch) on all fasta files in a folder.

for i in *.fa
do

NAME=$(basename $i .fa)

# run HMMEr search
echo "Running HMMsearch for $NAME"
hmmsearch --domtblout $NAME.domtblout --cut_ga ../domains_v12.txt $i


# run TAPscan script
echo "Running TAPscan Classify for $NAME"
../tapscan_classify.pl \
$NAME.domtblout \
../rules_v81.txt \
$NAME.output.1.family_classifications \
$NAME.output.2.family_statistics \
$NAME.output.3.subfamily_classifications \
../coverage_values_v10.txt

done

echo "Done!"
