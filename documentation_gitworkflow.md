# Git Workflow and Bioinformatics Pipeline Documentation
________________________________________
# Project Overview
This project demonstrates a complete bioinformatics workflow integrated with Git-based collaborative development practices. The pipeline processes raw sequencing FASTQ files through multiple stages including Quality Control, Sequence Trimming, Sequence Alignment, and Variant Calling.
The project also follows a structured Git workflow for version control, collaboration, documentation, and workflow tracking.
________________________________________
# Project Objectives
The primary objectives of this project are:
•	To simulate a real-world bioinformatics workflow
•	To automate sequencing data analysis using shell scripts
•	To maintain reproducible workflow execution
•	To implement structured Git workflow practices
•	To maintain logs and output validation for debugging
•	To generate biological variant outputs using bcftools
_____________________________________________________________________________
# Technologies and Tools Used
Bioinformatics Tools
•	FastQC
•	MultiQC
•	Trimmomatic
•	BWA MEM
•	SAMTOOLS
•	bcftools
# Development and Workflow Tools
•	Git
•	GitHub
•	Bash Shell Scripting
•	Linux Command Line
_____________________________________________________________________________
# Step 1: Repository Setup and Git Initialization
The project repository was initialized and cloned from GitHub for local development and workflow execution.
Commands Used
git init
git clone https://github.com/Meenalsharma27/pipeline_stimulator.git
cd pipeline_stimulator
git branch
Purpose
•	Initializes version control tracking
•	Creates a local copy of the repository
•	Connects local system with GitHub
•	Enables collaborative development
Contribution to Project
This step establishes the development environment and enables proper version control management throughout the project lifecycle.
________________________________________
# Step 2: Branch Workflow and Development Strategy
Feature branches were used instead of directly modifying the main branch.
Commands Used
git checkout -b feature/qc-module
git checkout Demo
Purpose
•	Prevents accidental modifications to the main branch
•	Separates development work into independent modules
•	Supports safe testing and debugging
Contribution to Project
Branch-based development improves collaboration, maintains project stability, and supports organized workflow management.
________________________________________
# Step 3: Project Directory Structure
The project follows a structured directory organization for scripts, outputs, logs, and results.
Directory Structure
pipeline_stimulator/
│
├── data/raw/
│   └── normal_R1.fastq.gz
│
├── logs/
│   ├── qc.log
│   ├── trim.log
│   ├── alignment.log
│   └── variant_call.log
│
├── results/
│   ├── qc/pre_trim/
│   ├── trim/
│   ├── alignment/
│   └── variants/
│
├── scripts/
│   ├── qc.sh
│   ├── trim.sh
│   ├── align.sh
│   └── variant_call.sh
│
├── README.md
└── documentation_gitworkflow.md
Purpose
•	Organizes workflow outputs efficiently
•	Separates scripts and logs clearly
•	Maintains reproducible pipeline structure
Contribution to Project
A proper directory structure improves workflow readability, debugging, scalability, and maintenance.
________________________________________
# Step 4: Quality Control Pipeline
The Quality Control (QC) pipeline evaluates the quality of raw sequencing FASTQ files using FastQC and MultiQC.
Script Used
qc.sh
Tools Used
•	FastQC
•	MultiQC
Input File
data/raw/normal_R1.fastq.gz
Command Used
./qc.sh normal_R1.fastq.gz
Workflow Performed
•	Validates FASTQ input file
•	Checks FastQC installation
•	Checks MultiQC installation
•	Creates output and log directories
•	Runs FastQC analysis
•	Generates MultiQC summary report
•	Verifies report generation
•	Saves execution logs
Output Directory
results/qc/pre_trim/
Generated Files
•	normal_R1_fastqc.html
•	normal_R1_fastqc.zip
•	multiqc_report.html
•	multiqc_data/
Log File
logs/qc.log
Purpose
•	Evaluates sequencing read quality
•	Detects low-quality reads and adapter contamination
•	Generates quality assessment reports
Contribution to Project
Quality Control ensures that only high-quality sequencing data proceeds to downstream analysis, improving the reliability of the entire pipeline.
________________________________________
# Step 5: Trimming Pipeline
The trimming pipeline removes low-quality bases and sequencing adapters using Trimmomatic.
Script Used
trim.sh
Tool Used
•	Trimmomatic
Command Used
./trim.sh normal_R1.fastq.gz
Workflow Performed
•	Validates FASTQ input
•	Checks Trimmomatic installation
•	Creates output directories
•	Performs read trimming
•	Saves logs
•	Verifies trimmed output generation
Trimming Parameters
LEADING:3
TRAILING:3
SLIDINGWINDOW:4:20
MINLEN:36
Output Directory
results/trim/
Generated Output
normal_R1_trimmed.fastq.gz
Log File
logs/trim.log
Purpose
•	Removes low-quality bases
•	Eliminates sequencing adapters
•	Improves downstream alignment accuracy
Contribution to Project
Read trimming improves data quality and ensures accurate alignment and variant calling results.
________________________________________
# Step 6: Alignment Pipeline
The alignment pipeline maps trimmed sequencing reads against the reference genome using BWA MEM and SAMTOOLS.
Script Used
align.sh
Tools Used
•	BWA MEM
•	SAMTOOLS
Command Used
./align.sh normal_R1_trimmed.fastq.gz genome.fa
Workflow Performed
•	Validates FASTQ and reference genome files
•	Checks BWA installation
•	Checks SAMTOOLS installation
•	Indexes reference genome
•	Performs sequence alignment using BWA MEM
•	Converts SAM to BAM format
•	Sorts BAM file
•	Indexes sorted BAM file
•	Saves workflow logs
•	Verifies output generation
Output Directory
results/alignment/
Generated Files
•	normal_R1.sam
•	normal_R1.bam
•	normal_R1_sorted.bam
•	normal_R1_sorted.bam.bai
Log File
logs/alignment.log
Status
•	Alignment pipeline executed successfully
•	Sorted BAM generated successfully
•	BAM indexing completed successfully
Purpose
•	Maps sequencing reads to reference genome
•	Generates aligned genomic data
•	Prepares files for variant calling analysis
Contribution to Project
Alignment is a critical step that identifies where sequencing reads belong in the reference genome, enabling downstream genomic analysis.
________________________________________
# Step 7: Variant Calling Pipeline
The variant calling pipeline identifies genomic variants from aligned BAM files using bcftools.
Script Used
variant_call.sh
Tools Used
•	bcftools
•	samtools
Command Used
./variant_call.sh normal_R1_sorted.bam genome.fa
Workflow Performed
•	Validates BAM and reference genome files
•	Checks BAM indexing
•	Generates mpileup data
•	Performs variant calling using bcftools
•	Generates VCF output
•	Saves execution logs
Output Directory
results/variants/
Generated Output
normal_R1.vcf
Example VCF Output
##fileformat=VCFv4.2
#CHROM POS ID REF ALT QUAL FILTER INFO
chr1 105 . A T 99 PASS .
chr1 210 . G C 85 PASS .
chr2 450 . T G 92 PASS .
VCF Field Interpretation
•	CHROM → Chromosome name
•	POS → Variant position
•	REF → Reference nucleotide
•	ALT → Alternate nucleotide
•	QUAL → Variant quality score
•	FILTER → Filtering status
Log File
logs/variant_call.log
Purpose
•	Detects genomic mutations and sequence variations
•	Generates VCF variant records
•	Supports downstream genomic studies
Contribution to Project
Variant calling is the final analytical stage of the pipeline and provides biologically meaningful genomic mutation information.
________________________________________
# Step 8: Logging System
Each pipeline module generates dedicated log files for workflow monitoring and debugging.
Log Files Generated
•	qc.log
•	trim.log
•	alignment.log
•	variant_call.log
Purpose
•	Tracks workflow execution
•	Records errors and debugging information
•	Maintains workflow history
Contribution to Project
The logging system improves debugging, reproducibility, workflow monitoring, and pipeline maintenance.
________________________________________
# Step 9: Git Development Workflow
Git was used for version control and collaborative project development.
Common Commands Used
Add Files
git add .
Commit Changes
git commit -m "Added QC workflow module"
git commit -m "Integrated variant calling workflow using bcftools"
Push Changes
git push origin Demo
Pull Latest Changes
git pull origin main
Purpose
•	Tracks project modifications
•	Maintains version history
•	Supports collaboration and recovery
Contribution to Project
Git workflow management ensures safe development, organized commits, reproducibility, and collaborative development.
________________________________________
# Step 10: Pull Request Workflow
Pull Requests (PRs) were used before merging feature branches into the main branch.
Workflow Followed
1.	Push feature branch to GitHub
2.	Create Pull Request
3.	Review code changes
4.	Resolve merge conflicts if required
5.	Merge approved changes
Purpose
•	Prevents direct changes to main branch
•	Supports code review process
•	Improves workflow quality
Contribution to Project
Pull Requests improve collaborative development and maintain project stability.
________________________________________
# Step 11: Merge Conflict Handling
Merge conflicts occur when multiple developers modify the same file.
Commands Used
git pull origin main
git add .
git commit -m "Resolved merge conflict"
Purpose
•	Maintains project consistency
•	Prevents overwriting changes
•	Ensures successful branch merging
Contribution to Project
Conflict resolution maintains clean project integration and collaborative workflow management.
________________________________________
# Step 12: Best Practices Followed
Development Best Practices
•	Never push directly to main branch
•	Always use feature branches
•	Pull latest updates before development
•	Use meaningful commit messages
•	Verify outputs after each pipeline stage
•	Maintain logs for debugging
•	Document workflows regularly
Example Commit Messages
git commit -m "Added QC workflow module"
git commit -m "Integrated real variant calling workflow using bcftools"
git commit -m "Updated Git workflow documentation"
Contribution to Project
Following best practices improves project organization, reproducibility, debugging efficiency, and collaborative development.
________________________________________
Final Conclusion
This project successfully demonstrates a complete bioinformatics sequencing analysis pipeline integrated with Git-based collaborative development practices.
The workflow performs:
•	Quality Control
•	Sequence Trimming
•	Sequence Alignment
•	Variant Calling
•	Logging and Output Validation
•	Git-based Version Control
The project successfully generated:
•	QC Reports
•	Trimmed FASTQ files
•	Sorted BAM alignment files
•	Indexed BAM files
•	Real VCF variant outputs
•	Execution log files
The integration of Git workflow practices ensured:
•	Safe collaborative development
•	Organized project structure
•	Reproducible workflow execution
•	Proper documentation maintenance
•	Efficient debugging and version control
This project simulates a real-world bioinformatics workflow environment used in genomic data analysis and collaborative software development.

