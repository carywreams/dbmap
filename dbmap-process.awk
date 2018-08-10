#!/usr/bin/awk -f

BEGIN {
    FS=":" ;\
    # simple header
    print "\ndigraph g {" ;\
    print "\n\tgraph [ pad=\"0.5\" ranksep=\"3\" ];" ;\
    print "\n\trankdir=LR" ;\
    print "\n\tnode [ fontsize = \"20\" shape = \"plain\" ];" ;\
    print "\n\tedge [ ]; \n" ;\
    print "\n\tlabel = \" Schema: " schemaname " Updated: " strftime("%Y.%m.%d %H:%M") "\";" ;\

    edgeCount = 0;\
}

$1 ~ /^gvNode/ {
    # collect the primary keys
    nodeDefPrimary [$2][$3] = "PRIMARY";
}

$1 ~ /^gvEdge/ {
    # infer the existence of nodes
    nodeDef[$2][$3] = "ref";
    nodeDef[$4][$5] = "ref";
    edgeDef [edgeCount++] = sprintf("\n\t\"%s\":%s->\"%s\":%s",$2,$3,$4,$5);

}

END {
#   merge nodeDefPrimary into nodeDef
#   this approach allows gvNodes and gvEdges to appear in any order in .gvData
    for (tbl in nodeDefPrimary) {
        for (pk in nodeDefPrimary[tbl]) {
            nodeDef[tbl][pk] = "PRIMARY";
        }
    }


    # add node definitions to the .gv file
    for (nodeelement in nodeDef) {
        printf("\"%s\" [ label = \"%s",nodeelement,nodeelement);
        # declare and clear the primary and ref buffers
        # enables primary key(s) to be placed at top of record
        pb = rb = "";
        for (nodefield in nodeDef[nodeelement]) {
            if (nodeDef[nodeelement][nodefield] == "PRIMARY") {
                pb = pb "| <" nodefield "> " nodefield "(primary) ";
            }
            else {
                rb = rb "| <" nodefield "> " nodefield ;
            }
        }
        print pb rb "\"\n\tshape = \"record\"];\n";
        # clear the primary and ref buffers
        pb = rb = "";
    }


    # add edge definitions to the .gv file
    while(edgeCount) printf edgeDef [--edgeCount];

    print "\n\n}\n";
}