#!/bin/bash

# ==========================================
# SIMULATED TRIMMING PIPELINE
# ==========================================

INPUT="data/raw/normal_R1.fastq.gz"

OUTDIR="results/trimmed"

LOGDIR="logs"

LOGFILE="$LOGDIR/trimming.log"

mkdir -p $OUTDIR
mkdir -p $LOGDIR

echo "===================================" | tee -a $LOGFILE
echo "TRIMMING PIPELINE STARTED" | tee -a $LOGFILE
echo "Date: $(date)" | tee -a $LOGFILE
echo "Input File: $INPUT" | tee -a $LOGFILE
echo "===================================" | tee -a $LOGFILE

# CHECK INPUT FILE
if [ ! -f "$INPUT" ]; then
    echo "ERROR: FASTQ file not found!" | tee -a $LOGFILE
    exit 1
fi

echo "Simulating trimming process..." | tee -a $LOGFILE

sleep 2

echo "Removing adapters..." | tee -a $LOGFILE
echo "Filtering low-quality reads..." | tee -a $LOGFILE
echo "Discarding short sequences..." | tee -a $LOGFILE

sleep 2

# CREATE DUMMY TRIMMED FILE

echo "SIMULATED TRIMMED FASTQ DATA" \
> $OUTDIR/normal_R1_trimmed.fastq.gz

echo "===================================" | tee -a $LOGFILE
echo "TRIMMING COMPLETED SUCCESSFULLY" | tee -a $LOGFILE
echo "Trimmed files generated in: $OUTDIR" | tee -a $LOGFILE
echo "===================================" | tee -a $LOGFILE