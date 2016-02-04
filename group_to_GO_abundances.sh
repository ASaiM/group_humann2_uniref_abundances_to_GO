#!/bin/bash

function msg_error() {
    printf "ERROR\n%15s   %s\n\n" "$1"
}

function prettyOpt() {
    printf "%15s   %s\n" "$1" "$2"
}

function shortUsage() {
    echo -e "Usage:\n\tgroup_to_GO_abundances [OPTIONS] -i humann2_gene_families_abundance -o go_slim_term_abundance"
    echo

    echo "Required options:"
    prettyOpt "-i" "Path to file with UniRef50 gene family abundance (HUMAnN2 output)"
    prettyOpt "-o" "Path to output file which will contain GO slim term abudances"
    echo
    echo "Other options:"
    prettyOpt "-a" "Path to basic Gene Ontology file"
    prettyOpt "-s" "Path to basic slim Gene Ontology file"
    prettyOpt "-u" "Path to file with HUMAnN2 correspondance betwen UniRef50 and GO"
    prettyOpt "-g" "Path to GoaTools scripts"
    prettyOpt "-p" "Path to HUMAnN2 scripts"

    prettyOpt "-h" "Print this help message"

    echo
    exit 0
}

MY_PATH=`dirname "$0"`

input_file=""
output_file=""
go_file=$MY_PATH"/data/go.obo"
slim_go_file=$MY_PATH"/data/goslim_metagenomics.obo"
humann2_uniref_go=$MY_PATH"/data/map_infogo1000_uniref50.txt"
goatools_path=""
humann2_path=`which humann2`

# Manage arguments
while getopts ":i:o:a:s:u:g:p:h" opt; do
    case $opt in
        i)
            input_file=$OPTARG >&2
            ;;
        o)
            output_file=$OPTARG >&2
            ;;
        a)
            go_file=$OPTARG >&2
            ;;
        s)
            slim_go_file=$OPTARG >&2
            ;;
        u)
            humann2_uniref_go=$OPTARG >&2
            ;;
        g)
            goatools_path=$OPTARG >&2
            ;;
        p)
            humann2_path=$OPTARG >&2
            ;;
        h)
            shortUsage ;
            break
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
  esac
done

if [ -z $input_file ]; then
    msg_error "Missing argument: -i"
    shortUsage;
fi

if [ -z $output_file ]; then
    msg_error "Missing argument: -o"
    shortUsage;
fi

if [ -z $goatools_path ]; then
    goatools_path="/usr/bin/"
fi

# Scripts
$MY_PATH"/download_datasets.sh"

if [ ! -d $MY_PATH"/tmp_data/" ]; then
    mkdir $MY_PATH"/tmp_data/"
fi

echo "Format HUMAnN2 UniRef50 GO mapping..."
python $MY_PATH"/src/format_humann2_uniref_go_mapping.py" \
    --uniref_go_mapping_input $humann2_uniref_go \
    --uniref_go_mapping_output $MY_PATH"/tmp_data/uniref_go_mapping_output.txt" \
    --go_names $MY_PATH"/tmp_data/humann2_go_names.txt"
echo ""

echo "Map to slim GO..."
python $goatools_path"/map_to_slim.py" \
    --association_file $MY_PATH"/tmp_data/humann2_go_names.txt" \
    $go_file \
    $slim_go_file \
    > $MY_PATH"/tmp_data/humman2_go_slim.txt"
echo ""

echo "Format slim GO"
python format_go_correspondance.py \
    --go_correspondance_input $MY_PATH"/tmp_data/humman2_go_slim.txt" \
    --go_correspondance_output $MY_PATH"/tmp_data/formatted_humman2_go_slim.txt"
echo ""

echo "Regroup UniRef50 to GO"
$humann2_path"_regroup_table" \
    -i $input_file \
    -f "sum" \
    -c $MY_PATH"/tmp_data/uniref_go_mapping_output.txt" \
    -o $MY_PATH"/tmp_data/humann2_go_abundances.txt"
echo ""

echo "Regroup GO to slim GO"
$humann2_path"_regroup_table" \
    -i $MY_PATH"/tmp_data/humann2_go_abundances.txt" \
    -f "sum" \
    -c $MY_PATH"/tmp_data/formatted_humman2_go_slim.txt" \
    -o $MY_PATH"/tmp_data/humann2_slim_go_abundances.txt"
echo ""

echo "Format slim GO abundance"
python $MY_PATH"/src/format_humann2_output.py" \
    --go_slim $slim_go_file \
    --humann2_output $MY_PATH"/tmp_data/humann2_slim_go_abundances.txt" \
    --formatted_humann2_output $output_file
echo ""

rm -rf $MY_PATH"/tmp_data/"
