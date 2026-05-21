#!/bin/bash

# ================================================================
#          TRIMMING PIPELINE : SIMULATED WORKFLOW
# ================================================================
#
# DESCRIPTION:
#   Simulates sequence trimming workflow steps
#   for FASTQ / FASTQ.GZ files
#
# WORKFLOW:
#
#   1. Validate input
#   2. Create directories
#   3. Simulate trimming
#   4. Generate output
#   5. Save logs
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
#
#   sample_trimmed.fastq.gz
#
# ================================================================


# ================================================================
# CHECK INPUT ARGUMENT
# ================================================================

if [ $# -ne 1 ]; then
    echo "=================================================="
    echo "ERROR: Invalid number of arguments"
    echo "Usage:"
    echo "    ./trim.sh <FASTQ_FILE>"
    echo ""
    echo "Example:"
    echo "    ./trim.sh sample.fastq.gz"
    echo "=================================================="
    exit 1
fi


# ================================================================
# INPUT FILE
# ================================================================

INPUT_FILE="$1"


# ================================================================
# OUTPUT DIRECTORIES
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
# START LOGGING
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "         TRIMMING PIPELINE STARTED                " | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"
echo "Date            : $(date)" | tee -a "$LOGFILE"
echo "Input File      : $INPUT_FILE" | tee -a "$LOGFILE"
echo "Output Directory: $OUTDIR" | tee -a "$LOGFILE"
echo "Log File        : $LOGFILE" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"


# ================================================================
# CHECK INPUT FILE EXISTS
# ================================================================

if [ ! -f "$INPUT_FILE" ]; then
    echo "ERROR: FASTQ file not found!" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# VALIDATE FILE FORMAT
# ================================================================

if [[ ! "$INPUT_FILE" =~ \.(fastq|fastq.gz)$ ]]; then
    echo "ERROR: Invalid file format!" | tee -a "$LOGFILE"
    echo "Accepted formats: .fastq or .fastq.gz" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# SAMPLE NAME
# ================================================================

SAMPLE_NAME=$(basename "$INPUT_FILE" .fastq.gz)
SAMPLE_NAME=$(basename "$SAMPLE_NAME" .fastq)

OUTPUT_FILE="$OUTDIR/${SAMPLE_NAME}_trimmed.fastq.gz"

echo "Sample Name : $SAMPLE_NAME" | tee -a "$LOGFILE"


# ================================================================
# SIMULATE TRIMMING
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "RUNNING TRIMMING SIMULATION..." | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"

echo "Removing low quality bases..." | tee -a "$LOGFILE"
sleep 1

echo "Removing adapter sequences..." | tee -a "$LOGFILE"
sleep 1

echo "Filtering short reads..." | tee -a "$LOGFILE"
sleep 1

cp "$INPUT_FILE" "$OUTPUT_FILE"


# ================================================================
# VERIFY OUTPUT
# ================================================================

if [ ! -f "$OUTPUT_FILE" ]; then
    echo "ERROR: Trimmed output not generated!" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# SUCCESS MESSAGE
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "TRIMMING COMPLETED SUCCESSFULLY" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"
echo "Sample Processed : $SAMPLE_NAME" | tee -a "$LOGFILE"
echo "Trimmed File     : $OUTPUT_FILE" | tee -a "$LOGFILE"
echo "Log File         : $LOGFILE" | tee -a "$LOGFILE"
echo "Completion Time  : $(date)" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"