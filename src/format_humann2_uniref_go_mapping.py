#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import argparse
import re

def format_humann2_uniref_go_mapping(args):
    with open(args.uniref_go_mapping_input, "r") as uniref_go_mapping_input:
        with open(args.uniref_go_mapping_output,"w") as uniref_go_mapping_output:
            with open(args.go_names,"w") as go_names:
                for line in uniref_go_mapping_input.readlines():
                    split_line = line[:-1].split('\t')
                    go_name = ":".join(split_line[0].split(':')[:2])
                    split_line[0] = go_name

                    uniref_go_mapping_output.write("\t".join(split_line) + "\n")
                    go_names.write(go_name + "\t" + go_name + "\n")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--uniref_go_mapping_input', required=True)
    parser.add_argument('--uniref_go_mapping_output', required=True)
    parser.add_argument('--go_names', required=True)
    args = parser.parse_args()

    format_humann2_uniref_go_mapping(args)