Group humann2 uniref50 abundances to Gene Ontology (GO) slim terms
==================================================================

[![DOI](https://zenodo.org/badge/19862/ASaiM/group_humann2_uniref_abundances_to_GO.svg)](https://zenodo.org/badge/latestdoi/19862/ASaiM/group_humann2_uniref_abundances_to_GO)

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

## Get the code

Clone the repository:

```
$ git clone https://github.com/ASaiM/group_humann2_uniref_abundances_to_GO.git
$ cd group_humann2_uniref_abundances_to_GO
```

## Install the requirements

This tool needs:

- [HUMAnN2](http://huttenhower.sph.harvard.edu/humann2/manual#markdown-header-initial-installation)
- [GoaTools](https://github.com/tanghaibao/goatools) with

```
$ pip install -r requirements.txt
$ git clone https://github.com/tanghaibao/goatools.git
```

## Download required datasets

Several datasets, such as Gene Ontology, must be downloaded using:

```
$ download_datasets.sh
```

# Usage 

```
$ group_to_GO_abundances [OPTIONS] -i humann2_gene_families_abundance -o go_slim_term_abundance
```

To get more information about options:

```
$ group_to_GO_abundances -h
```

# License 

This tool is released under Apache 2 License. See the [LICENSE file](https://raw.githubusercontent.com/ASaiM/group_humann2_uniref_abundances_to_GO/master/LICENSE)
for details.
