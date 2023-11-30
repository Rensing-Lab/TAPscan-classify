# TAPscan Classify

TAPscan (perl) script to detect TAPs (Transcription Associated Proteins) in your sequence data.

## Requirements & Installation

1. Install HMMER according to its [installation instructions](http://hmmer.org/documentation.html) for your system.
2. [Perl](https://www.perl.org/get.html) is required (script was tested with `v5.34.0`)


## Usage

***Step 1: Filter dataset for isoforms if necessary***

This script can be used if you have a fasta file containing isoforms. The first part of the IDs
has to be the same up to a certain pattern which has to be given as a parameter. The script
then groups all proteins with the same ID part together and uses the longest one as major
isoform. All the other sequences will be written into an `iso.fa` file. The script also adds the letter
code at the beginning of the fasta ID. The letter code has to be given using the `-c` option, the
output directory using the `-o` option, the input fasta file using the `-i` option and the pattern used
for splitting using the `-p` option.

```
python split_isoform_dot.py -o outputfile -I CAMSA.fa -c CAMSA -p .
```

***Step 2: Run TAPscan Classify***

TAPscan is a comprehensive tool for annotating TAPs with a special focus on species
belonging to the Archaeplastida. In general, the detection of TAPs is based on the detection
of highly conserved protein domains.

During the first step, each sequence out of a species
protein set is scanned for protein domains (stored as profile Hidden Markov Models) using
hmmsearch. The domains file (`domains_v12.txt)` consists of 154 profile HMMs and functions
as the domain reference during the hmmsearch command. v
Afterwards, by applying the TAPscan script (`tapscan_classify.pl`), specialized rules are applied
to finally assign the protein sequences to TAP families based on the detected domains in the
previous step. With the latest TAPscan v4, a protein set can be scanned for 137 different TAP
families with high accuracy through applying GA-thresholds and coverage values


```bash
hmmsearch --domtblout sample.domtblout --cut_ga domains_v12.txt sample.fa

tapscan_classify.pl \
sample.domtblout \
rules_v81.txt \
sample.output.1.family_classifications.txt \
sample.output.2.family_statistics.txt \
sample.output.3.subfamily_classifications.txt \
coverage_values_v10.txt
```

A script to run these commands on all FASTA files in a folder can be found in `tapscan_run.sh`


## Output Files

TAPscan provides the user with three different output file formats. Each output file is
semicolon-separated. Output 1 contains the detected domains and finally assigned TAP family
for each gene ID. If domains are assigned to a sequence but not all rules are fulfilled, the
sequence is assigned to `0_no_family_found`. Output 2 is a summary of the number of
members for each TAP family. Output 3 is similar to Output 1 but contains additional
information about subfamilies.



**Output.1: Family Classifications**

```
GENE ID;TAP_FAMILY;NUMBER_OF_FAMILIES_FOUND;DOMAINS;…
ARATH_AT1G01010.1;NAC;1;NAM;
ARATH_AT1G01030.1;ABI3/VP1;1;B3;
ARATH_AT1G01040.2;Dicer;1;PAZ;Ribonuclease_3;Helicase_C;dsrm;DEAD;
ARATH_AT1G01060.1;MYB-related;1;Myb_DNA-binding;
ARATH_AT1G01110.2;0_no_family_found;0;IQ;
```

**Output.2: Family Statistics**

```
TAP_FAMILY;NUMBER_MEMBERS
0_no_family_found;676
ABI3/VP1;64
ADA2;2
Alfin-like;8
```

**Output.3: Subfamily Classifications**

```
GENE_ID;TAP_FAMILY;SUBFAMILY;NUMBER_OF_FAMILIES_FOUND;DOMAINS;…
ARATH_AT1G01010.1;NAC;-;1;NAM;
ARATH_AT1G01030.1;ABI3/VP1;-;1;B3;
ARATH_AT1G01040.2;Dicer;-;1;PAZ;Ribonuclease_3;Helicase_C;dsrm;DEAD;
ARATH_AT1G01060.1;MYB;MYB-related;1;Myb_DNA-binding;
ARATH_AT1G01110.2;0_no_family_found;-;0;IQ;
ARATH_AT1G01160.2;GIF;-;1;SSXT
```

