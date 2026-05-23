#!/bin/bash

# ================================================================
#            TRIMMING PIPELINE : FASTP WORKFLOW
# ================================================================
#
# DESCRIPTION:
#   Performs sequence trimming using fastp
#
# WORKFLOW:
#   1. Validate input FASTQ
#   2. Create output folders
#   3. Run fastp trimming
#   4. Save reports
#   5. Verify output
#
# USAGE:
#
#   chmod +x trim.sh
#
#   ./trim.sh sample.fastq
#
#   OR
#
#   ./trim.sh sample.fastq.gz
#
# OUTPUT:
#
# results/trim/
#   sample_trimmed.fastq.gz
#
# logs/
#   trim.log
#
# ================================================================


# CHECK INPUT

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "./trim.sh <FASTQ_FILE>"
    exit 1
fi


INPUT_FILE="$1"


# CHECK FILE EXISTS

if [ ! -f "$INPUT_FILE" ]; then
    echo "ERROR: Input FASTQ file not found!"
    exit 1
fi


# VALIDATE FORMAT

if [[ ! "$INPUT_FILE" =~ \.(fastq|fastq.gz)$ ]]; then
    echo "ERROR: Accepted formats:"
    echo ".fastq"
    echo ".fastq.gz"
    exit 1
fi


# CHECK FASTP

if ! command -v fastp &> /dev/null
then
    echo "ERROR: fastp not installed"
    echo "Install fastp first"
    exit 1
fi


# CREATE DIRECTORIES

OUTDIR="results/trim"
LOGDIR="logs"

mkdir -p "$OUTDIR"
mkdir -p "$LOGDIR"


LOGFILE="$LOGDIR/trim.log"


# SAMPLE NAME

SAMPLE_NAME=$(basename "$INPUT_FILE" .fastq.gz)
SAMPLE_NAME=$(basename "$SAMPLE_NAME" .fastq)

OUTPUT_FILE="$OUTDIR/${SAMPLE_NAME}_trimmed.fastq.gz"

HTML_REPORT="$OUTDIR/${SAMPLE_NAME}_fastp.html"
JSON_REPORT="$OUTDIR/${SAMPLE_NAME}_fastp.json"


# LOGGING

echo "==================================================" | tee -a "$LOGFILE"
echo "FASTP TRIMMING STARTED" | tee -a "$LOGFILE"
echo "Date : $(date)" | tee -a "$LOGFILE"
echo "Input : $INPUT_FILE" | tee -a "$LOGFILE"
echo "Output : $OUTPUT_FILE" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"


# RUN FASTP

fastp \
-i "$INPUT_FILE" \
-o "$OUTPUT_FILE" \
-h "$HTML_REPORT" \
-j "$JSON_REPORT" \
2>> "$LOGFILE"


# VERIFY OUTPUT

if [ ! -f "$OUTPUT_FILE" ]; then
    echo "ERROR: Trimmed file not generated!" | tee -a "$LOGFILE"
    exit 1
fi


# SUCCESS

echo "==================================================" | tee -a "$LOGFILE"
echo "TRIMMING COMPLETED SUCCESSFULLY" | tee -a "$LOGFILE"
echo "Trimmed File : $OUTPUT_FILE" | tee -a "$LOGFILE"
echo "HTML Report : $HTML_REPORT" | tee -a "$LOGFILE"
echo "JSON Report : $JSON_REPORT" | tee -a "$LOGFILE"
echo "Finished : $(date)" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"