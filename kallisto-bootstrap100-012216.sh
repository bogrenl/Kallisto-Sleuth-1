#! /usr/bin/env bash

#BSUB -J alngenomebam[1-3] 
#BSUB -e alngenomebam.%J.%I.err
#BSUB -o alngenomebam.%J.%I.out
#BSUB -R rusage[mem=125]
#BSUB -R span[hosts=1]

#(#BSUB -n 12) --> note -n 12 is the number of threads requested (this did not
#work --> removed 
#gave error: User or one of user's groups does not have enough job slots.
#Job not submitted.

#the above also sets up the job array to do this 3 times

#load modules
#module load gcc
#module load kallisto

#location of the output folder
output=/vol3/home/bogrenl/projects/RNASeq/kallisto-output-bootstrap
#this script runs the kallisot alignment to the TLS NOT (rm) masked genome 

#specify the directories where files are located
fileloc=/vol1/home/martins/projects/brainRNAediting/data

#the genome reference file (in this case,repeatmasked genome) data directory
#don't need this here--> genome already index for kallisto alignment
#ref=$fileloc/TLS/Ictidomys_tridecemlineatus.spetri2.dna.toplevel.fa.gz

#location of the previously indexed genome
index=/vol3/home/bogrenl/projects/RNASeq/scripts/my_scripts/kallisto/tlgs_kallisto_index.idx

samples=(B83_1_ACAGTG_L001 B62_16_GTTTCG_L002 B84_7_AGTCAA_L001)

#all samples below:
#B30_2_GCCAAT_L001 B32_14_CCGTCC_L002
#B33_20_ATTCCT_L002 B153_3_CTTGTA_L001 B64_22_ACTTGA_L003
#B163_9_ATGTCA_L001 B65_5_TTAGGC_L001 B66_28_GTGAAA_L003 B31_8_AGTTCC_L001
#B67_11_CGATGT_L002 B68_17_CGTACG_L002 B69_15_GTGGCC_L002
#B34_26_GCCAAT_L003 B70_21_ATCACG_L003 B53_6_GATCAG_L001 B72_23_TAGCTT_L003
#B54_12_TGACCA_L002 B74_29_TTAGGC_L003 B55_4_GTGAAA_L001 B77_13_CAGATC_L002
#B57_18_GAGTGG_L002 B78_27_CTTGTA_L003 B58_24_GGCTAC_L003
#B79_19_ACTGAT_L002 B59_10_GTCCGC_L001 B80_25_ACAGTG_L003
#B61_30_GATCAG_L003 B83_1_ACAGTG_L001 B62_16_GTTTCG_L002 B84_7_AGTCAA_L001)

#this is the value of the job index
sampleid=${samples[$(($LSB_JOBINDEX - 1))]}

#the two datafiles read1 and read2 from the best qual file, for each sample
reads=$fileloc/BrainRest_fastqfiles

read1=$reads/"$sampleid""_R1_001.fastq.gz"
read2=$reads/"$sampleid""_R2_001.fastq.gz"

#now do the pseudo alignments and read counts
kallisto quant -i $index -b 100 -o $output/"$sampleid""_kallisto" $read1 $read2 


