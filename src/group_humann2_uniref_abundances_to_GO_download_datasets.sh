#!/usr/bin/env bash

go_file=$1
slim_go_file=$2
humann2_uniref_go=$3

if [ ! -f $go_file ]; then
    echo "Download basic Gene Ontology..."
    wget http://geneontology.org/ontology/go.obo
    mv "go.obo" $go_file
fi 
if [ ! -f $slim_go_file ]; then
    echo "Download metagenomic slim Gene Ontology..."
    wget http://www.geneontology.org/ontology/subsets/goslim_metagenomics.obo
    mv "goslim_metagenomics.obo" $slim_go_file
fi

if [ ! -f $humann2_uniref_go ]; then
    echo "Download humann2 correspondance between Uniref50 and GO"
    wget https://bitbucket.org/biobakery/humann2/raw/d1ac153083d48a5384e3b3d3597b9e36b1a4606e/humann2/data/misc/map_infogo1000_uniref50.txt.gz
    gunzip map_infogo1000_uniref50.txt.gz
    mv "map_infogo1000_uniref50.txt" $humann2_uniref_go
fi