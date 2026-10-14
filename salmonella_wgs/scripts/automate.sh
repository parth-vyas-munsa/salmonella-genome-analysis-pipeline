project="/home/bioinformatics/bacterial_wgs"

mkdir -p "$project/sra" "$project/fastq"

prefetch SRR41022238 --output-directory "$project/sra"


fasterq-dump "$project/sra/SRR41022238/SRR41022238.sra" \
  --split-files \
  --threads 4 \
  --outdir "$project/fastq"


mkdir -p "$project/qc" "$project/trimmed"

fastqc "$project/fastq/SRR41022238_1.fastq" \
       "$project/fastq/SRR41022238_2.fastq" \
       --outdir="$project/qc" \
       --threads 4


fastp \
  -i "$project/fastq/SRR41022238_1.fastq" \
  -I "$project/fastq/SRR41022238_2.fastq" \
  -o "$project/trimmed/SRR41022238_1.trimmed.fastq.gz" \
  -O "$project/trimmed/SRR41022238_2.trimmed.fastq.gz" \
  --html "$project/qc/fastp_report.html" \
  --json "$project/qc/fastp_report.json" \
  --thread 4


explorer.exe "$(wslpath -w "$project/qc/fastp_report.html")"

mkdir -p "$project/assembly"

spades.py \
  -1 "$project/trimmed/SRR41022238_1.trimmed.fastq.gz" \
  -2 "$project/trimmed/SRR41022238_2.trimmed.fastq.gz" \
  -o "$project/assembly/spades" \
  --threads 4 \
  -m 5

###############quast download for assembly quality

CONDA_NO_PLUGINS=true conda create --solver classic \
  -n quast_env -c conda-forge -c bioconda quast

conda activate quast_env

quast.py --version

quast.py "$project/assembly/spades/contigs.fasta" \
  -o "$project/quast" \
  -t 2 \
  --min-contig 200

######quast ended check quality like n30 or 50

cat "$project/quast/report.txt"



explorer.exe "$(wslpath -w "$project/quast/report.html")"


#######################cheking complete .......

##############BUSCO to assess bacterial genome completeness###############3

conda deactivate quast_env

CONDA_NO_PLUGINS=true conda create --solver classic \
  -n busco_env -c conda-forge -c bioconda busco

conda activate busco_env

busco \
  -i "$project/assembly/spades/contigs.fasta" \
  -m genome \
  -l bacteria_odb10 \
  -o salmonella_busco \
  --out_path "$project/busco" \
  -c 2


#############################complete busco 


################annotation######################

conda deactivate busco_env


CONDA_NO_PLUGINS=true conda create --solver classic \
  -n bakta_env \
  -c conda-forge -c bioconda \
  bakta


conda activate bakta_env
mkdir -p "$project/bakta_db"

bakta_db download \
  --output "$project/bakta_db" \
  --type light


ls -lh "$project/assembly/spades/contigs.fasta"
bakta --version
bakta_db list

mkdir -p "$project/annotation/bakta"

bakta \
  --db /home/bioinformatics/bacterial_wgs/bakta_db \
  --output "$project/annotation/bakta" \
  --prefix salmonella_wgs \
  --genus Salmonella \
  --species enterica \
  --strain SRR41022238 \
  --threads 2 \
  "$project/assembly/spades/contigs.fasta"


##################annotation complete#############


###############MLST (Multilocus Sequence Typing)###########

conda deactivate bakta_env
CONDA_NO_PLUGINS=true conda create --solver classic \
  -n mlst_env \
  -c conda-forge -c bioconda \
  mlst


conda activate mlst_env

mlst --version

#######################################################333

mlst --full "$project/assembly/spades/contigs.fasta" \
  | tee "$project/mlst_results.tsv"

#######################################################

conda deactivate mlst_env

#######################AMR ANALYSIS#############

CONDA_NO_PLUGINS=true conda create --solver classic \
  -n amr_env \
  -c conda-forge -c bioconda \
  ncbi-amrfinderplus

conda activate amr_env
amrfinder --version


amrfinder --update

mkdir -p amr

amrfinder \
  --nucleotide assembly/spades/contigs.fasta \
  --organism Salmonella \
  --output amr/amrfinder_results.tsv

###################################################3
#############do proksee for visualization
