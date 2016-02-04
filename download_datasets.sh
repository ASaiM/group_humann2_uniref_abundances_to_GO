#!/bin/bash

data_dir="data/"

if [ ! -d $data_dir ]; then
    mkdir $data_dir
fi

cd $data_dir

echo "Download Gene Ontology (basic and metagenomic slim)..."
if [ ! -f "go.obo" ]; then
    wget http://geneontology.org/ontology/go.obo
fi 
if [ ! -f "goslim_metagenomics.obo" ]; then
    wget http://www.geneontology.org/ontology/subsets/goslim_metagenomics.obo
fi

echo "Download humann2 correspondance between Uniref50 and GO"
if [ ! -f "map_infogo1000_uniref50.txt" ]; then
    wget https://bitbucket.org/biobakery/humann2/raw/d1ac153083d48a5384e3b3d3597b9e36b1a4606e/humann2/data/misc/map_infogo1000_uniref50.txt.gz
    gunzip map_infogo1000_uniref50.txt.gz
fi