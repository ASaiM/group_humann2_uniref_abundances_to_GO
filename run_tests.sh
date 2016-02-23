#!/bin/bash
cd "test-data"

../install_dependencies.sh

echo "Launch script to group humann2 uniref50 abundances to Gene Ontology (GO) slim terms"
echo "==================================================================================="
../group_to_GO_abundances.sh \
    -i "humann2_gene_families.csv" \
    -a "go_02_22_2016.obo" \
    -s "goslim_metagenomics_02_22_2016.obo" \
    -u "map_infogo1000_uniref50_02_22_2016.txt" \
    -g "goatools/scripts/" \
    -p "humann2/humann2_scripts/" \
    -m "molecular_function_abundances.txt" \
    -b "biological_process_abundance.txt" \
    -c "cellular_component_abundance.txt" 
echo ""

echo "Check differences between generated and expected molecular function abundance file"
echo "=================================================================================="
diff "molecular_function_abundances.txt" \
    "expected_molecular_function_abundances.txt"
echo ""

echo "Check differences between generated and expected biological process abundance file"
echo "=================================================================================="
diff "biological_process_abundance.txt" \
    "expected_biological_process_abundance.txt"
echo ""

echo "Check differences between generated and expected cellular component abundance file"
echo "=================================================================================="
diff "cellular_component_abundance.txt" \
    "expected_cellular_component_abundance.txt"
echo ""