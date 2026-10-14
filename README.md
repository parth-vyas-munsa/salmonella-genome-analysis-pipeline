# salmonella-genome-analysis-pipeline
ion, virulence profiling, and MLST-based characterization using open-source bioinformatics tools.End-to-end *Salmonella enterica* whole-genome sequencing (WGS) analysis workflow covering read quality control, genome assembly, assembly quality assessment, genome annotation, AMR gene identificat

there are two scripts 1. automate.sh if you run this in linux you can do assembly  based wgs of salmonella and you can change tha sra accession id and i use light spades database for annotation of genome cause my laptop cant support large files 

and 2. variant calling .sh for variant or refrence based wgs var calling where i filter variants and separate 
for automate.sh script your folder look like  bacterial_wgs/

sra/
Downloaded SRA data


fastq/
Raw paired-end reads


qc/
FastQC and fastp reports


trimmed/
Quality-filtered reads


assembly/spades/
contigs.fasta and assembly outputs


quast/
Assembly quality reports


busco/
Genome completeness results


bakta_db/
Bakta database files


annotation/bakta/
Genome annotation outputs


amr/
AMRFinder results


proksee/
Genome visualization exports


results/
Final result tables


plots/
Figures and visualizations


reports/
Final project report


scripts/
Reusable pipeline scripts


docs/
Workflow documentation


README.md
Project overview, methods, results and limitations


.gitignore



and after run var_call.sh your folder look like
bacterial_wgs/
├── sra/
│   └── SRR41022238/
│       └── SRR41022238.sra
│
├── fastq/
│   ├── SRR41022238_1.fastq
│   └── SRR41022238_2.fastq
│
├── qc/
│   ├── SRR41022238_1_fastqc.html
│   ├── SRR41022238_1_fastqc.zip
│   ├── SRR41022238_2_fastqc.html
│   ├── SRR41022238_2_fastqc.zip
│   ├── fastp_report.html
│   └── fastp_report.json
│
├── trimmed/
│   ├── SRR41022238_1.trimmed.fastq.gz
│   └── SRR41022238_2.trimmed.fastq.gz
│
├── reference/
│   ├── GCF_000006945.2_ASM694v2_genomic.fna.gz
│   ├── GCF_000006945.2_ASM694v2_genomic.fna
│   ├── GCF_000006945.2_ASM694v2_genomic.fna.amb
│   ├── GCF_000006945
etc  
