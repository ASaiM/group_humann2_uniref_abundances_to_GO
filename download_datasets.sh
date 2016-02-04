#!/bin/bash

MY_PATH=`dirname "$0"`
data_dir=$MY_PATH"/data/"

if [ ! -d $data_dir ]; then
    mkdir $data_dir
fi

cd $data_dir

if [ ! -f "go.obo" ]; then
    echo "Download basic Gene Ontology..."
    wget http://geneontology.org/ontology/go.obo
fi 
if [ ! -f "goslim_metagenomics.obo" ]; then
    echo "Download metagenomic slim Gene Ontology..."
    wget http://www.geneontology.org/ontology/subsets/goslim_metagenomics.obo
fi

if [ ! -f "map_infogo1000_uniref50.txt" ]; then
    echo "Download humann2 correspondance between Uniref50 and GO"
    wget https://bitbucket.org/biobakery/humann2/raw/d1ac153083d48a5384e3b3d3597b9e36b1a4606e/humann2/data/misc/map_infogo1000_uniref50.txt.gz
    gunzip map_infogo1000_uniref50.txt.gz
fi