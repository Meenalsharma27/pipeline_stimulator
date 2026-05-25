# Bioinformatics Pipeline Test Cases

## Test 1: Docker Image Build

Input:
- Dockerfile

Expected Result:
- Image builds successfully without errors

---

## Test 2: QC Stage

Input:
- normal_R1.fastq.gz

Expected Result:
- FastQC HTML report generated
- MultiQC report generated

---

## Test 3: Trimming Stage

Input:
- FASTQ file

Expected Result:
- Trimmed FASTQ generated
- fastp HTML report generated
- fastp JSON report generated

---

## Test 4: Alignment Stage

Input:
- Trimmed FASTQ
- Reference genome

Expected Result:
- SAM file generated
- BAM file generated
- Sorted BAM file generated
- BAM index generated

---

## Test 5: Variant Calling Stage

Input:
- Sorted BAM
- Reference genome

Expected Result:
- VCF file generated

---

## Test 6: Log Generation

Expected Result:
- qc.log generated
- trim.log generated
- alignment.log generated
- variant_call.log generated