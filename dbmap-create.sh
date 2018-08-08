#!/usr/bin/env bash

cat $1.gvData | ./dbmap-process.awk > $1.gv
dot -Tpdf $1.gv > $1.pdf