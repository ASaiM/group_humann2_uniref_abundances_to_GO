#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import os
import argparse
import re


def get_next_go(go_slim):
    read_file = True
    while read_file:
        line = go_slim.readline()
        if not line: 
            read_file = False
        if line.startswith("[Term]"):
            read_file = False

    if not line:
        return None

    go = {}
    go["id"] = ""
    go["name"] = ""
    go["namespace"] = ""

    for i in range(3):
        line = go_slim.readline()
        if line.startswith("id:"):
            go["id"] = line[:-1].split(": ")[1]
        elif line.startswith("name:"):
            go["name"] = line[:-1].split(": ")[1]
        elif line.startswith("namespace:"):
            go["namespace"] = line[:-1].split(": ")[1]
        else:
            raise ValueError("wrong descriptor: " + line )
    return go

def extract_go_slim_annotations(args):
    go_annotations = {}
    with open(args.go_slim, "r") as go_slim:
        go = get_next_go(go_slim)
        while go != None:
            go_annotations.setdefault(go["id"],{})
            go_annotations[go["id"]]["name"] = go["name"]
            go_annotations[go["id"]]["namespace"] = go["namespace"]
            go = get_next_go(go_slim)
    return go_annotations

def format_humann2_output(args, go_annotations):
    with open(args.humann2_output, "r") as humann2_output:
        output_files = {}
        output_files['molecular_function'] = open(args.molecular_function_output_file,"w")
        output_files['molecular_function'].write("GO id\tGO name\tAbundance\n")

        output_files['biological_process'] = open(args.biological_processes_output_file,"w")
        output_files['biological_process'].write("GO id\tGO name\tAbundance\n")

        output_files['cellular_component'] = open(args.cellular_component_output_file,"w")
        output_files['cellular_component'].write("GO id\tGO name\tAbundance\n")

        for line in humann2_output.readlines()[1:]:
            split_line = line[:-1].split('\t')
            go_id = split_line[0]
            abundance = split_line[1]

            if go_id == "UNGROUPED":
                continue

            namespace = go_annotations[go_id]["namespace"]

            if not go_annotations.has_key(go_id):
                string = go_id + " has not found annotations"
                raise ValueError(string)

            output_files[namespace].write(go_id + '\t')
            output_files[namespace].write(go_annotations[go_id]["name"] + '\t')
            output_files[namespace].write(abundance + '\n')

        output_files['molecular_function'].close()
        output_files['biological_process'].close()
        output_files['cellular_component'].close()

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--go_slim', required=True)
    parser.add_argument('--humann2_output', required=True)
    parser.add_argument('--molecular_function_output_file', required=True)
    parser.add_argument('--biological_processes_output_file', required=True)
    parser.add_argument('--cellular_component_output_file', required=True)
    args = parser.parse_args()

    go_annotations = extract_go_slim_annotations(args)
    format_humann2_output(args, go_annotations)