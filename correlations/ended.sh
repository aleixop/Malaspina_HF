#!/bin/bash

INPUT_NW=NW.txt
INPUT_ASV=ASV_Counts_sizefilter.txt
INPUT_ENV=ENV.txt
OUTPUT_NW=NW_CoOcc.tsv
METHODS=CO

ENDED='/Users/aleix/scripts/EnDED/build/EnDED'

${ENDED} \
    --input_network_file $INPUT_NW \
    --methods ${METHODS} \
    --II_DPI_abundance_file $INPUT_ASV \
    --output_network_file $OUTPUT_NW

rm triplet.txt

echo log_* > LOG_NW_CoOcc.tsv

less log_* >> LOG_NW_CoOcc.tsv

rm log_*

for ENVID in Temp Fluo Cond Ox_mL_L
do
   # Parameters
   ##############################################
   less NW.txt > NW_temp.txt
   tail -n+2 ASV_ENV_${ENVID}.txt >> NW_temp.txt
   INPUT_NW=NW_temp.txt
   INPUT_ASV=ASV_Counts_sizefilter.txt
   INPUT_ENV=ENV.txt
   OUTPUT_TRIPLET=Triplet_ENV_${ENVID}.tsv
   OUTPUT_NW=NW_ENV_${ENVID}.tsv
   # Run with methods: SP,II,DPI,CO
   ##############################################
   METHODS=II,DPI
 
   ## EnDED
   ##############################################
   ${ENDED} \
       --input_network_file $INPUT_NW \
       --methods ${METHODS} \
       --II_permutation_iteration 1000 \
       --do_pre_jointP_comp \
       --II_DPI_abundance_file $INPUT_ASV \
       --II_DPI_ENVparameter_file $INPUT_ENV \
       --output_network_file $OUTPUT_NW \
       --output_triplet_info $OUTPUT_TRIPLET
   echo log_* > LOG_NW_ENV_$ENVID.tsv
   less log_* >> LOG_NW_ENV_$ENVID.tsv
   rm log_*
done
