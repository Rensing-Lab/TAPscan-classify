#!/usr/bin/env bash

tapscan_script='../tapscan_classify_v4.76.pl'
domains="../domains_v13.txt"
rules="../rules_v82.txt"
coverage="../coverage_values_v11.txt"

# script to run TAPscan classify (including hmmsearch) on all fasta files in a folder.

for i in *.fa
do

NAME=$(basename $i .fa)

# run HMMEr search
echo "Running HMMsearch for $NAME"
hmmsearch --domtblout $NAME.domtblout --cut_ga ${domains} $i


# run TAPscan script
echo "Running TAPscan Classify for $NAME"
$tapscan_script \
$NAME.domtblout \
$rules \
$NAME.output.1.family_classifications \
$NAME.output.2.family_statistics \
$NAME.output.3.subfamily_classifications \
$coverage

done

echo "Done!"
