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

Tool            | Version
---             | :---
gawk            | GNU Awk 4.1.3, API: 1.1 (GNU MPFR 3.1.4, GNU MP 6.1.0)
dot             | graphviz version 2.38.0 (20140413.2041)
_pdf viewer_    | I used gnome document viewer, 3.18.2

The selection of gawk was driven by their multi-dimensional array implementation.

## Process

### No Direct MySQL Remote Access
+ copy dbmap-raw.sql and dbmap-collect.sh to target server
+ login to target server and run ```./dbmap-collect.sh schema_name```
+ copy resulting ```schema_name.gvData``` file back to local machine
+ run ```dbmap-create.sh schema_name```
+ open ```schema_name.pdf``` with your pdf reader

### With Direct MySQL Remote Access
__prerequisite: the sever supports remote access__

+ locally, run ```sed 's/SCHEMA_NAME/<schema_name>/g' dbmap-raw.sql | mysql -u <user> -p -h <server> > schema_name.gvData```
  + replacing ```<schema_name>``` with the name of your MySQL schema
  + replacing ```<user>``` with the name of your MySQL user id
  + replacing ```<server>``` with the name or IP of your MySQL server
+ run ```dbmap-create.sh schema_name```
+ open ```schema_name.pdf``` with your pdf reader



