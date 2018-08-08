# PURPOSE

Create a rudimentary map of relationships from actual mySQL schema data.

## Technique

Queries mySQL's information_schema.key_column_usage table for information
about a specific schema. Extracted information is labelled with one of two prefixes:
"gvNode" or "gvEdge".

The information is placed in a file with the extension ```.gvData``` and 
further processed to create both a .gv file and a .pdf file.

The .gv file is retained so the user may manually customize the digraph 
before re-processing it with dot. For example: adding subgraphs to the .gv 
file before creating a PDF.

## Required

Tool | Version
---  | :---
gawk | GNU Awk 4.1.3, API: 1.1 (GNU MPFR 3.1.4, GNU MP 6.1.0)
dot  | graphviz version 2.38.0 (20140413.2041)
pdf  | I used gnome document viewer, 3.18.2

The selection of gawk was driven by their multi-dimensional array implementation.

## Process
+ copy dbmap-raw.sql and dbmap-collect.sh to target server
+ login to target server and run ```./dbmap-collect.sh schema_name```
+ copy resulting ```schema_name.gvData``` file back to local machine
+ run ```dbmap-create.sh schema_name```
+ open ```schema_name.pdf``` with your pdf reader

## TODO
+ detect and move PRIMARY KEY(s) to the top of the record
+ add labels to rays, detailing relationship
+ add dates to PDF output
+ add schema name to PDF output
+ add error/failure detection to shell scripts
+ add niceties to shell scripts, removing file extensions when possible
+ add option for collecting data with remote connection to server

