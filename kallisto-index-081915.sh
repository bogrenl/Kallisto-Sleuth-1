#! /usr/bin/env bash

#BSUB -J kallisto_index
#BSUB -o kallisto_index.%J.%I.out
#BSUB -e kallisto_index.%J.%I.err

set -o nounset -o pipefail -o errexit -x

#load modules
#module load gcc
#module load kallisto

data=/vol3/home/bogrenl/projects/genome/TLGS
 
genometoindex=$data/Ictidomys_tridecemlineatus.spetri2.dna_rm.toplevel.fa


#kallisto INDEX
#kallisto index [arguments] FASTA-files
#Required argument:
#-i, --index=STRING -->  Filename for the kallisto index to be constructed


kallisto index -i tlgs_kallisto_index_test.idx $genometoindex
