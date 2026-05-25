#!/bin/bash

# ================================================================
#                QC PIPELINE : FASTQC + MULTIQC
# ================================================================
#
# DESCRIPTION:
#   This script performs Quality Control (QC) analysis
#   on real FASTQ/FASTQ.GZ sequencing files using:
#
#       1. FastQC
#       2. MultiQC
#
# ------------------------------------------------
# REQUIRED DEPENDENCIES (FOR DOCKER CONTAINER)
# ------------------------------------------------
#
# The Docker/container developer should install:
#
#   - fastqc
#   - multiqc
#   - openjdk (required for FastQC)
#   - python3
#   - pip
#
# Example Docker dependencies:
#
#   apt-get install -y fastqc default-jre python3 python3-pip
#   pip install multiqc
#
# ------------------------------------------------
# USAGE
# ------------------------------------------------
#
#   chmod +x qc.sh
#
#   ./qc.sh sample.fastq.gz
#
#   OR
#
#   ./qc.sh sample.fastq
#
# ------------------------------------------------
# OUTPUT
# ------------------------------------------------
#
#   results/qc/pre_trim/
#
#       sample_fastqc.html
#       sample_fastqc.zip
#       multiqc_report.html
#       multiqc_data/
#
# ------------------------------------------------
# AUTHOR
# ------------------------------------------------
#   Bioinformatics QC Module
#
# ================================================================


# ================================================================
# CHECK INPUT ARGUMENT
# ================================================================

if [ $# -ne 1 ]; then
    echo "=================================================="
    echo "ERROR: Invalid number of arguments"
    echo "Usage:"
    echo "    ./qc.sh <FASTQ_FILE>"
    echo ""
    echo "Example:"
    echo "    ./qc.sh sample.fastq.gz"
    echo "=================================================="
    exit 1
fi


# ================================================================
# INPUT FILE
# ================================================================

INPUT_FILE="$1"


# ================================================================
# DIRECTORY STRUCTURE
# ================================================================

OUTDIR="results/qc/pre_trim"
LOGDIR="logs"


# ================================================================
# LOG FILE
# ================================================================

LOGFILE="$LOGDIR/qc.log"


# ================================================================
# CREATE DIRECTORIES
# ================================================================

mkdir -p "$OUTDIR"
mkdir -p "$LOGDIR"


# ================================================================
# START LOGGING
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "              QC PIPELINE STARTED                 " | tee -a "$LOGFILE"
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
# CHECK FASTQC INSTALLATION
# ================================================================

if ! command -v fastqc &> /dev/null
then
    echo "ERROR: FastQC is not installed!" | tee -a "$LOGFILE"
    echo "" | tee -a "$LOGFILE"
    echo "Install using:" | tee -a "$LOGFILE"
    echo "    sudo apt install fastqc" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# CHECK MULTIQC INSTALLATION
# ================================================================

if ! command -v multiqc &> /dev/null
then
    echo "ERROR: MultiQC is not installed!" | tee -a "$LOGFILE"
    echo "" | tee -a "$LOGFILE"
    echo "Install using:" | tee -a "$LOGFILE"
    echo "    pip install multiqc" | tee -a "$LOGFILE"
    exit 1
fi


# ================================================================
# EXTRACT SAMPLE NAME
# ================================================================

BASENAME=$(basename "$INPUT_FILE")

# Removes .fastq.gz OR .fastq
SAMPLE_NAME=$(basename "$INPUT_FILE" .fastq.gz)
SAMPLE_NAME=$(basename "$SAMPLE_NAME" .fastq)

echo "Sample Name     : $SAMPLE_NAME" | tee -a "$LOGFILE"


# ================================================================
# RUN FASTQC
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "RUNNING FASTQC ANALYSIS..." | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"

fastqc "$INPUT_FILE" \
--outdir "$OUTDIR" \
2>> "$LOGFILE"


# ================================================================
# CHECK FASTQC STATUS
# ================================================================

if [ $? -ne 0 ]; then
    echo "ERROR: FastQC execution failed!" | tee -a "$LOGFILE"
    exit 1
fi

echo "FASTQC completed successfully." | tee -a "$LOGFILE"


# ================================================================
# VERIFY FASTQC OUTPUT
# ================================================================

if [ ! -f "$OUTDIR/${SAMPLE_NAME}_fastqc.html" ]; then
    echo "ERROR: FastQC report not generated!" | tee -a "$LOGFILE"
    exit 1
fi

echo "FastQC report generated successfully." | tee -a "$LOGFILE"


# ================================================================
# RUN MULTIQC
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "RUNNING MULTIQC..." | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"

multiqc "$OUTDIR" \
--outdir "$OUTDIR" \
2>> "$LOGFILE"


# ================================================================
# CHECK MULTIQC STATUS
# ================================================================

if [ $? -ne 0 ]; then
    echo "ERROR: MultiQC execution failed!" | tee -a "$LOGFILE"
    exit 1
fi

echo "MULTIQC completed successfully." | tee -a "$LOGFILE"


# ================================================================
# VERIFY MULTIQC OUTPUT
# ================================================================

if [ ! -f "$OUTDIR/multiqc_report.html" ]; then
    echo "ERROR: MultiQC report not generated!" | tee -a "$LOGFILE"
    exit 1
fi

echo "MultiQC report generated successfully." | tee -a "$LOGFILE"


# ================================================================
# FINAL SUCCESS MESSAGE
# ================================================================

echo "==================================================" | tee -a "$LOGFILE"
echo "         QC PIPELINE COMPLETED SUCCESSFULLY       " | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"
echo "Sample Processed : $SAMPLE_NAME" | tee -a "$LOGFILE"
echo "FastQC Report    : $OUTDIR/${SAMPLE_NAME}_fastqc.html" | tee -a "$LOGFILE"
echo "MultiQC Report   : $OUTDIR/multiqc_report.html" | tee -a "$LOGFILE"
echo "Log File         : $LOGFILE" | tee -a "$LOGFILE"
echo "Completion Time  : $(date)" | tee -a "$LOGFILE"
echo "==================================================" | tee -a "$LOGFILE"

