#!/usr/bin/env bash

echo "Launch group humann2 uniref50 abundances to Gene Ontology (GO) slim terms"
echo "=========================================================================="
bash group_humann2_uniref_abundances_to_GO.sh \
    -i "test-data/humann2_gene_families.csv" \
    -a "test-data/go_02_22_2016.obo" \
    -s "test-data/goslim_metagenomics_02_22_2016.obo" \
    -u "test-data/map_infogo1000_uniref50_02_22_2016.txt" \
    -g `which map_to_slim.py | xargs -n1 dirname` \
    -p `which humann2.py | xargs -n1 dirname` \
    -m "test-data/molecular_function_abundances.txt" \
    -b "test-data/biological_process_abundance.txt" \
    -c "test-data/cellular_component_abundance.txt" 
echo ""

echo "Check differences between generated and expected molecular function abundance file"
echo "=================================================================================="
diff "test-data/molecular_function_abundances.txt" \
    "test-data/expected_molecular_function_abundances.txt"
echo ""

echo "Check differences between generated and expected biological process abundance file"
echo "=================================================================================="
diff "test-data/biological_process_abundance.txt" \
    "test-data/expected_biological_process_abundance.txt"
echo ""

echo "Check differences between generated and expected cellular component abundance file"
echo "=================================================================================="
diff "test-data/cellular_component_abundance.txt" \
    "test-data/expected_cellular_component_abundance.txt"
echo ""