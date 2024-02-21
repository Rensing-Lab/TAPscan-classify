#!/usr/bin/env bash
# USAGE: tapscan_run.sh path/to/folder/with/fastafiles

tapscan_script='./tapscan_classify_v4.76.pl'
domains="domains_v13.txt"
rules="rules_v82.txt"
coverage="coverage_values_v11.txt"

# use current directory if none supplied as parameter
seqfolder=${1:-.}

echo "Running on folder: $seqfolder"

shopt -s nullglob
for i in ${seqfolder}/*.fa;
do

NAME=$(basename $i .fa)

# run HMMr search
echo "Running HMMsearch for $NAME"
hmmsearch --domtblout "$NAME.domtblout" --cut_ga $domains "$i"

# run TAPscan script
echo "Running TAPscan Classify for $NAME"

$tapscan_script \
"$NAME.domtblout" \
$rules \
"$NAME.output.1.family_classifications.txt" \
"$NAME.output.2.family_statistics.txt" \
"$NAME.output.3.subfamily_classifications.txt" \
$coverage

done
shopt -u nullglob


echo "Done!"
