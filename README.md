Group abundances of UniRef50 gene families obtained with HUMAnN2 to Gene Ontology (GO) slim terms with relative abundances
==========================================================================================================================

[![DOI](https://zenodo.org/badge/doi/10.5281/zenodo.49952.svg)](http://dx.doi.org/10.5281/zenodo.49952)

[![Build Status](https://travis-ci.org/ASaiM/group_humann2_uniref_abundances_to_GO.svg?branch=master)](https://travis-ci.org/ASaiM/group_humann2_uniref_abundances_to_GO)

# Introduction

[HUMAnN2](http://huttenhower.sph.harvard.edu/humann2) is a pipeline to profile
the presence/absence and abundance of microbial pathways in community of microbiota
sequencing data. One output is a file with UniRef50 gene family abundances. 
HUMAnN2 proposes a script to [regroup Uniref50 to GO](http://huttenhower.sph.harvard.edu/humann2/manual#markdown-header-5-regroup-table-features), 
but used GO terms are too precise to get a broad overview of the ontology content.

The tool described here contains scripts to group UniRef50 abundances obtained 
using main HUMANn2 script (Gene families) to GO slim terms. [GO slim](http://geneontology.org/page/go-slim-and-subset-guide)
is a subset of the terms in the whole GO. For this tool, metagenomics GO slim terms
developed by Jane Lomax and the InterPro group.

Script in this tool calls:

- A script to formate correspondance between Uniref50 and GO available in HUMAnN2
package
- [HUMAnN2 script to regroup Uniref50 to GO](http://huttenhower.sph.harvard.edu/humann2/manual#markdown-header-5-regroup-table-features)
using formatted correspondance
- [GoaTools script to map GO terms to GO slim terms](https://github.com/tanghaibao/goatools)
- A script to format output of previous script
- [HUMAnN2 script to regroup GO to GO slim terms](http://huttenhower.sph.harvard.edu/humann2/manual#markdown-header-5-regroup-table-features)
- A script to format generated file

# Installation

## Using `conda`

```
$ conda install group_humann2_uniref_abundances_to_GO
```

It will manage installation of all dependencies.

## Using code source

### Get the code

Clone the repository:

```
$ git clone https://github.com/ASaiM/group_humann2_uniref_abundances_to_GO.git
$ cd group_humann2_uniref_abundances_to_GO
```

### Install the requirements

This tool needs:

- Git
- Mercurial
- VirtualEnv
- Python with pip

Once these tools installed, you can run:

```
$ install_dependencies.sh
```

This script will launch a virtual environment and install:

- [HUMAnN2](http://huttenhower.sph.harvard.edu/humann2/manual#markdown-header-initial-installation)
- [GoaTools](https://github.com/tanghaibao/goatools) > 0.6.4 with

```
$ pip install -r requirements.txt
$ git clone https://github.com/tanghaibao/goatools.git
```

## Using Galaxy

A wrapper was also developed and is available on [Galaxy ToolShed](https://toolshed.g2.bx.psu.edu/). It can be installed on any Galaxy instance.

# Usage 

```
$ ./group_humann2_uniref_abundances_to_GO.sh [OPTIONS] -i humann2_gene_families_abundance -m molecular_function_abundance -b biological_process_abundance -c cellular_component_abundance
```

To get more information about options:

```
$ ./group_humann2_uniref_abundances_to_GO.sh -h
```

# Test

To test the tool, you can run:

```
$ ./group_humann2_uniref_abundances_to_GO_run_tests.sh
```

This script will install dependencies and then run `group_to_GO_abundances.sh` on test data available in `test-data` directory. This data contains:

- A file with UniRef50 gene family abundances from HUMAnN2 (computed on [gut microbiota data of lean women](https://www.ebi.ac.uk/metagenomics/projects/SRP000319/samples/SRS000998/runs/SRR029687/results/versions/1.0)): `humann2_gene_families.csv`
- A file with basic Gene Ontology, downloaded on 02/22/2016: `go_02_22_2016.obo`
- A file with metagenomic slim Gene Ontology, downloaded on 02/22/2016: `goslim_metagenomics_02_22_2016.obo`
- A file with humann2 correspondance between Uniref50 and GO, downloaded on 02/22/2016: `map_infogo1000_uniref50_02_22_2016.txt`

After running `group_to_GO_abundances.sh`, `run_tests.sh` checks if generated output files correspond to expected ones:

- `expected_molecular_function_abundances.txt` with expected abundance of GO related to molecular functions
- `expected_biological_process_abundances.txt` with expected abundance of GO related to biological processes
- `expected_cellular_component_abundances.txt` with expected abundance of GO related to cellular components

# License 

This tool is released under Apache 2 License. See the [LICENSE file](https://raw.githubusercontent.com/ASaiM/group_humann2_uniref_abundances_to_GO/master/LICENSE)
for details.
