#!/bin/bash

# ==========================================
# SIMULATED FASTQC QC PIPELINE
# ==========================================

INPUT="data/raw/normal_R1.fastq.gz"

OUTDIR="results/qc/pre_trim"

LOGDIR="logs"

LOGFILE="$LOGDIR/qc.log"

mkdir -p $OUTDIR
mkdir -p $LOGDIR

echo "===================================" | tee -a $LOGFILE
echo "FASTQC ANALYSIS STARTED" | tee -a $LOGFILE
echo "Date: $(date)" | tee -a $LOGFILE
echo "Input File: $INPUT" | tee -a $LOGFILE
echo "===================================" | tee -a $LOGFILE

# CHECK INPUT FILE
if [ ! -f "$INPUT" ]; then
    echo "ERROR: FASTQ file not found!" | tee -a $LOGFILE
    exit 1
fi

echo "Simulating FastQC analysis..." | tee -a $LOGFILE

sleep 2

echo "Per base sequence quality : PASS" | tee -a $LOGFILE
echo "Per sequence GC content   : PASS" | tee -a $LOGFILE
echo "Adapter contamination     : WARN" | tee -a $LOGFILE
echo "Sequence duplication      : PASS" | tee -a $LOGFILE

# CREATE DUMMY REPORTS

echo "<html><body><h1>Simulated FastQC Report</h1></body></html>" \
> $OUTDIR/normal_R1_fastqc.html

echo "Dummy zip content" \
> $OUTDIR/normal_R1_fastqc.zip

echo "<html><body><h1>Simulated MultiQC Report</h1></body></html>" \
> $OUTDIR/multiqc_report.html

mkdir -p $OUTDIR/multiqc_data

echo "===================================" | tee -a $LOGFILE
echo "QC PIPELINE COMPLETED SUCCESSFULLY" | tee -a $LOGFILE
echo "Reports generated in: $OUTDIR" | tee -a $LOGFILE
echo "===================================" | tee -a $LOGFILE
