#!/usr/bin/env bash
# keep the .gv file around in the event subgraphs are to be added manually
# the .gv file may only be a starting point for a much cleaner diagram
./dbmap-process.awk -v schemaname="$1" $1.gvData > $1.gv
dot -Tpdf $1.gv > $1.pdf