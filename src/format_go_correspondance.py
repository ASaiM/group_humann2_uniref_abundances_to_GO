#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import argparse
import re

def format_go_correspondance(args):
    go = {}
    with open(args.go_correspondance_input, "r") as go_correspondance_input:
        for line in go_correspondance_input.readlines():
            if not line.startswith('GO'):
                continue

            split_line = line[:-1].split('\t')
            go_name = split_line[0]

            if split_line[1] == "":
                continue

            slim_go_names = split_line[1].split(';')

            for split_go_name in slim_go_names:
                go.setdefault(split_go_name,[]).append(go_name)
    
    with open(args.go_correspondance_output,"w") as go_correspondance_output:
        for go_name in go:
            go_correspondance_output.write(go_name + '\t')
            go_correspondance_output.write("\t".join(go[go_name]) + "\n") 

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--go_correspondance_input', required=True)
    parser.add_argument('--go_correspondance_output', required=True)
    args = parser.parse_args()

    format_go_correspondance(args)