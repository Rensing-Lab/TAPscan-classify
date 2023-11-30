#!/usr/bin/env bash
# USAGE: tapscan_run.sh path/to/folder/with/fastafiles

# use current directory if none supplied as parameter
seqfolder=${1:-.}

echo "Running on folder: $seqfolder"

shopt -s nullglob
for i in ${seqfolder}/*.fa;
do

NAME=$(basename $i .fa)

# run HMMr search
echo "Running HMMsearch for $NAME"
hmmsearch --domtblout "$NAME.domtblout" --cut_ga domains_v12.txt "$i"

# run TAPscan script
echo "Running TAPscan Classify for $NAME"

./tapscan_classify.pl \
"$NAME.domtblout" \
rules_v81.txt \
"$NAME.output.1.family_classifications.txt" \
"$NAME.output.2.family_statistics.txt" \
"$NAME.output.3.subfamily_classifications.txt" \
coverage_values_v10.txt

done
shopt -u nullglob


echo "Done!"
