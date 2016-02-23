#!/bin/bash

echo "Launch virtualenv and install dependencies"
echo "=========================================="
virtualenv --no-site-packages .venv
source .venv/bin/activate
pip install -r ../requirements.txt
echo ""

echo "Install goatools"
echo "================"
if [[ ! -d goatools ]]; then
    git clone https://github.com/tanghaibao/goatools.git
fi
echo ""

echo "Install humann2"
echo "==============="
if [[ ! -f humann2/humann2_scripts/humann2_regroup_table ]]; then
    hg clone https://bitbucket.org/biobakery/humann2
    cd humann2
    python setup.py install --bypass-dependencies-install --install-scripts=./humann2_scripts
    cd ../
fi
echo ""