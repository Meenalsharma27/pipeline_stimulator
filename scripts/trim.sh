#!/bin/bash

# ================================================================
#            TRIMMING PIPELINE : TRIMMOMATIC WORKFLOW
# ================================================================
#
# DESCRIPTION:
#   This script performs sequence trimming on
#   FASTQ / FASTQ.GZ files using Trimmomatic
#
# WORKFLOW:
#
#   1. Validate input FASTQ
#   2. Create output folders
#   3. Run trimming
#   4. Save logs
#   5. Verify output
#
# ------------------------------------------------
# REQUIRED TOOLS
# ------------------------------------------------
#
# Install:
#
#   sudo apt install trimmomatic
#
# ------------------------------------------------
# USAGE
# ------------------------------------------------
#
#   chmod +x trim.sh
#
#   ./trim.sh sample.fastq
#
#   OR
#
#   ./trim.sh sample.fastq.gz
#
# ------------------------------------------------
# OUTPUT
# ------------------------------------------------
#
# results/trim/
#
#   sample_trimmed.fastq.gz
#
# logs/
#
#   trim.log
#
# ================================================================


# ================================================================
# CHECK INPUT ARGUMENT
# ================================================================

if [ $# -ne 1 ]; then
    echo "Usage:"
    echo "./trim.sh <FASTQ_FILE>"
    exit 1
fi


# ================================================================
# INPUT FILE
# ================================================================

INPUT_FILE="$1"


# ================================================================
# CHECK FILE EXISTS
# ================================================================

if [ ! -f "$INPUT_FILE" ]; then
    echo "ERROR: Input file not found!"
    exit 1
fi


# ================================================================
# VALIDATE EXTENSION
# ================================================================

if [[ ! "$INPUT_FILE" =~ \.(fastq|fastq.gz)$ ]]; then
    echo "ERROR: Accepted formats:"
    echo ".fastq"
    echo ".fastq.gz"
    exit 1
fi


# ================================================================
# CHECK TRIMMOMATIC
# ================================================================

if ! command -v trimmomatic &> /dev/null
then
    echo "ERROR: Trimmomatic not installed"
    echo "Install:"
    echo "sudo apt install trimmomatic"
    exit 1
fi


# ================================================================
# DIRECTORY STRUCTURE
# ================================================================

OUTDIR="results/trim"
LOGDIR="logs"

mkdir -p "$OUTDIR"
mkdir -p "$LOGDIR"


# ================================================================
# LOG FILE
# ================================================================

LOGFILE="$LOGDIR/trim.log"


# ================================================================
# SAMPLE NAME
# ================================================================

SAMPLE_NAME=$(basename "$INPUT_FILE" .fastq.gz)
SAMPLE_NAME=$(basename "$SAMPLE_NAME" .fastq)

OUTPUT_FILE="$OUTDIR/${SAMPLE_NAME}_trimmed.fastq.gz"


# ================================================================
# START LOGGING
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "TRIMMING PIPELINE STARTED" | tee -a "$LOGFILE"
echo "Date : $(date)" | tee -a "$LOGFILE"
echo "Input : $INPUT_FILE" | tee -a "$LOGFILE"
echo "Output : $OUTPUT_FILE" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"


# ================================================================
# RUN TRIMMOMATIC
# ================================================================

echo "Running trimming..." | tee -a "$LOGFILE"

trimmomatic SE \
-phred33 \
"$INPUT_FILE" \
"$OUTPUT_FILE" \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:4:20 \
MINLEN:36 \
2>> "$LOGFILE"


# ================================================================
# CHECK STATUS
# ================================================================

if [ $? -ne 0 ]; then
    echo "ERROR: Trimming failed" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# VERIFY OUTPUT
# ================================================================

if [ ! -f "$OUTPUT_FILE" ]; then
    echo "ERROR: Trimmed file not generated" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# SUCCESS MESSAGE
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "TRIMMING COMPLETED SUCCESSFULLY" | tee -a "$LOGFILE"
echo "Sample : $SAMPLE_NAME" | tee -a "$LOGFILE"
echo "Trimmed File : $OUTPUT_FILE" | tee -a "$LOGFILE"
echo "Log : $LOGFILE" | tee -a "$LOGFILE"
echo "Finished : $(date)" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"