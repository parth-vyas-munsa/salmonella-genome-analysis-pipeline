# Salmonella Bacterial Whole-Genome Sequencing (WGS) Analysis

I worked on this project to understand how bacterial whole-genome sequencing data can be processed and analyzed using bioinformatics tools. The main focus was to perform de novo genome assembly, assess genome quality, annotate the assembled genome, and identify genetic variants by comparing sequencing reads against a reference genome.

I used *Salmonella enterica* sequencing data and built a workflow combining assembly-based analysis and reference-based variant calling. I also organized the workflow and results so that the analysis can be reviewed and reproduced.

## Project Objectives

- Perform quality control on raw sequencing reads.
- Remove low-quality bases and adapter sequences.
- Assemble sequencing reads into contigs using SPAdes.
- Evaluate genome assembly quality and completeness.
- Annotate bacterial genomic features.
- Align sequencing reads to a reference genome.
- Call and filter genetic variants using BCFtools.
- Separate SNPs and insertions/deletions (indels).
- Prepare output files for downstream analysis and reporting.

## Dataset and Reference Genome

**Organism:** *Salmonella enterica*  
**SRA accession:** `SRR41022238`  
**Reference assembly:** `GCF_000006945.2`  
**Reference strain:** *Salmonella enterica* serovar Typhimurium LT2

Dataset: [NCBI SRA](https://www.ncbi.nlm.nih.gov/sra/)

Reference genome: [NCBI Assembly GCF_000006945.2](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000006945.2/)

The reference genome was used for read alignment and variant calling. Since the reference represents the Typhimurium LT2 strain, its suitability for the sequenced isolate should be checked before interpreting the variants biologically.

## Workflow Overview

```text
Raw FASTQ Reads
      |
      v
Quality Control - FastQC
      |
      v
Read Trimming and Filtering - fastp
      |
      +------------------------------+
      |                              |
      v                              v
De Novo Assembly                 Reference Genome
      |                              |
      v                              v
SPAdes Assembly                  BWA Alignment
      |                              |
      v                              v
Assembly Quality                 Sorted and Indexed BAM
      |                              |
      v                              v
QUAST / BUSCO (if used)          BCFtools Variant Calling
      |                              |
      v                              v
Genome Annotation                Variant Filtering
      |                              |
      v                              v
    Bakta                       SNPs and Indels
      |                              |
      v                              v
Annotated Genome                 Variant Tables and Interpretation
      |
      v
MLST (Multilocus Sequence Typing)
      |
      v
AMR ANALYSIS
      |
      v
VISUALIZATION USING PROKSEE 
## Tools Used

| Tool | Purpose |
|---|---|
| FastQC | Assess raw and processed read quality |
| fastp | Trim adapters and filter low-quality reads |
| MultiQC | Combine quality-control reports |
| SPAdes | Perform de novo bacterial genome assembly |
| QUAST | Evaluate assembly statistics, if used |
| BUSCO | Assess genome completeness, if used |
| Bakta | Annotate bacterial genomic features |
| BWA | Align reads against a reference genome |
| SAMtools | Process, sort, index, and summarize alignments |
| BCFtools | Call, filter, and extract variants |
| SnpEff | Predict variant effects, if used |

## 1. Read Quality Control

I started by checking the sequencing-read quality with FastQC. The reports can be used to examine per-base quality, GC content, adapter contamination, sequence duplication, and other quality indicators.

I used fastp for read trimming and filtering. MultiQC was used to bring quality-control reports together for easier review.

**Outputs to include:**
- FastQC HTML reports
- fastp HTML and JSON reports
- MultiQC report

## 2. De Novo Genome Assembly

After read preprocessing, I used SPAdes to assemble the paired-end reads into contigs.

De novo assembly reconstructs longer genomic sequences directly from sequencing reads without requiring the reference genome to build the initial assembly.

Assembly quality can be evaluated using:
- Total assembly length
- Number of contigs
- N50
- Longest contig
- GC content
- Genome completeness, if assessed using BUSCO

These metrics help determine whether the assembly is suitable for downstream annotation and comparative analysis.

**Main output:** `contigs.fasta`

## 3. Assembly Quality Assessment

Assembly statistics provide an overview of the quality and continuity of the assembled genome. QUAST can be used to summarize contig statistics, while BUSCO can estimate completeness using conserved single-copy genes from an appropriate lineage dataset.

Assembly statistics should be interpreted together rather than relying on N50 or completeness alone. Contamination, fragmented assemblies, and unusual GC content can affect downstream conclusions.

## 4. Genome Annotation

The assembled contigs can be annotated using Bakta to identify genomic features such as:
- Protein-coding genes
- Transfer RNA genes
- Ribosomal RNA genes
- Other annotated genomic features

Annotation adds biological information to the assembled sequences and provides a basis for downstream comparative analysis.

The annotation output can be used to investigate genes and genomic regions of interest. Predicted functions should be treated as computational annotations rather than experimental confirmation.

## 5. Reference-Based Read Alignment

For variant analysis, I aligned the processed paired-end reads to the reference genome using BWA.

I then used SAMtools to convert and sort the alignment files, index the sorted BAM file, and summarize alignment statistics.

**Important outputs:**
- Sorted BAM file
- BAM index
- Alignment statistics from `samtools flagstat`

Alignment quality and the suitability of the reference genome are important because poorly mapped reads can lead to unreliable variant calls.

## 6. SNP and Indel Calling

I used BCFtools for reference-based variant calling. The workflow uses `bcftools mpileup` to summarize read evidence and `bcftools call` to identify candidate variants.

The resulting VCF file contains candidate differences between the sample and the selected reference.

The variants can be filtered by quality and separated into:

- **SNPs:** Single-nucleotide polymorphisms, representing single-base substitutions.
- **Indels:** Insertions or deletions of bases relative to the reference.

The analysis produces raw and filtered VCF files. SNP and indel tables can then be exported for inspection and downstream analysis.

A quality threshold such as `QUAL >= 30` is a starting filter, not proof that every retained variant is correct. Read depth, mapping quality, allele support, repetitive regions, and reference suitability should also be assessed.

## 7. Variant Interpretation and Downstream Analysis

After extracting SNPs and indels, the next step is to investigate their potential biological significance.

Possible downstream analyses include:

- Annotating variants with gene and predicted consequence information.
- Identifying variants that fall within coding or regulatory regions, where supported by the annotation.
- Investigating candidate variants in genes of biological interest.
- Comparing variant patterns with other isolates, where suitable datasets are available.
- Exploring potential links to antimicrobial resistance or virulence using validated tools and appropriate databases.

A detected variant alone does not demonstrate antimicrobial resistance or increased virulence. Phenotypic conclusions require appropriate evidence and careful interpretation.

## Project Structure

The directory layout below illustrates how I organize the analysis. Actual paths and filenames may differ depending on the tools and steps completed.

```text
bacterial_wgs/
├── README.md
├── reference.md
├── environment.yml
├── raw/
├── trimmed/
├── qc/
├── assembly/
│   └── spades/
├── annotation/
│   └── bakta/
├── reference/
├── alignment/
├── variants/
└── report/
```

## Reproducibility

I used Linux command-line tools to process the sequencing data and organize the outputs. The `environment.yml` file documents the intended software environment, and `reference.md` records the dataset, reference genome, software documentation, and interpretation notes.

To reproduce the analysis, users should verify the input file paths, software versions, reference assembly, and parameters before running the workflow. Any database required by an annotation tool must be downloaded separately.

## Limitations

- The selected reference strain may not be the closest match to the sequenced isolate.
- Assembly quality depends on sequencing quality, coverage, and the assembler settings.
- Automated annotation can assign uncertain or incomplete functional descriptions.
- Variant calls may be affected by mapping errors, repetitive sequences, coverage, and filtering choices.
- SNP and indel identification alone does not establish antimicrobial resistance, virulence, or clinical significance.
- The results should be interpreted as a bioinformatics analysis, not as experimental validation.

##
