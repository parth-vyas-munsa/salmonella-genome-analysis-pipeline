References and Resources

1. Project Dataset

Organism: Salmonella enterica
SRA accession: SRR41022238
Data type: Whole-genome sequencing (WGS)
Sequencing platform: Verify using the NCBI SRA record.

NCBI SRA: https://www.ncbi.nlm.nih.gov/sra/

NCBI SRA Run Selector: https://www.ncbi.nlm.nih.gov/Traces/study/

The accession identifies the sequencing run used in this project. Confirm the isolate, serovar, sequencing platform, and library information from the accession record before finalizing the report.

2. Reference Genome

Reference accession: GCF_000006945.2
Reference assembly: ASM694v2
Reference organism: Salmonella enterica serovar Typhimurium LT2

NCBI Assembly: https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000006945.2/

Reference FASTA download:
https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/006/945/GCF_000006945.2_ASM694v2/GCF_000006945.2_ASM694v2_genomic.fna.gz

Important limitation: This reference is the Typhimurium LT2 genome. It should not automatically be assumed to be the closest reference for the sequenced isolate. Check the isolate's serovar and genomic similarity before interpreting variants.

3. Software and Documentation

Tool

Purpose

Documentation

SRA Toolkit

Download sequencing reads

https://github.com/ncbi/sra-tools

FastQC

Read quality assessment

https://www.bioinformatics.babraham.ac.uk/projects/fastqc/

fastp

Read quality filtering and trimming

https://github.com/OpenGene/fastp

MultiQC

Aggregate quality-control reports

https://multiqc.info/

SPAdes

De novo genome assembly

https://github.com/ablab/spades

QUAST

Genome assembly quality assessment

https://quast.sourceforge.net/

BWA

Read alignment to a reference

https://github.com/lh3/bwa

SAMtools

SAM/BAM processing and alignment statistics

https://www.htslib.org/

BCFtools

Variant calling and VCF processing

https://samtools.github.io/bcftools/

Bakta

Bacterial genome annotation

https://github.com/oschwengers/bakta

SnpEff

Variant effect annotation, if used

https://pcingola.github.io/SnpEff/

Only list tools in the final methods section if they were actually used in the completed analysis.

4. Databases

NCBI Assembly: Reference genome and assembly metadata.

NCBI SRA: Raw sequencing reads and run metadata.

Bakta database: Required for Bakta genome annotation; download separately and record the database version.

SnpEff database: Required for SnpEff annotation; record the exact database name and version if used.

AMR databases: If antimicrobial resistance analysis is performed, document the tool, database, database version, and date accessed.

Database versions can change. Record the versions used for the actual analysis rather than assuming that the latest version was used.

5. Reproducibility

The following information should accompany the project:

SRA accession and reference assembly accession.

Software versions and Conda environment configuration (environment.yml).

Commands or scripts used for each workflow stage.

Quality-control reports and assembly statistics.

Annotation outputs and variant-calling parameters.

Database versions and relevant limitations.

6. Interpretation Notes

Sequencing-read quality and alignment statistics should be reviewed before variant interpretation.

A high-quality variant call is not guaranteed by a QUAL threshold alone; read depth, mapping quality, allele support, and genomic context should also be considered.

Reference-based variant analysis and de novo assembly answer different questions and should be reported separately.

Variant calls may be affected by reference choice, repetitive regions, contamination, and sequencing errors.

Antimicrobial resistance or virulence predictions require appropriate databases and should not be presented as experimentally confirmed phenotypes.
