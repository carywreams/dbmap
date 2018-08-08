#!/usr/bin/awk -f

BEGIN {
    FS=":" ;\
    print "\ndigraph g {" ;\
    print "\n\tgraph [ pad=\"0.5\" ranksep=\"3\" ];" ;\
    print "\n\trankdir=LR" ;\
    print "\n\tnode [ fontsize = \"20\" shape = \"plain\" ];" ;\
    print "\n\tedge [ ]; \n" ;\
    edgeCount = 0;\
    nodeCount = 0;\
}

$1 ~ /^gvNode/ {
    nodeDef [$2][$3] = nodeCount++;
}

$1 ~ /^gvEdge/ {
    edgeDef [edgeCount++] = sprintf("\n\t\"%s\":%s->\"%s\":%s",$2,$3,$4,$5);
}

END {

#    lastNode = "";
#    for (nodeelement in nodeDef) {
#        for (nodefield in nodeDef[nodeelement]) {
#        split(nodeelement,nodes,SUBSEP);
#        if (nodes[1] != lastNode) {
#            if (lastNode != "") { print "\"\n\tshape = \"record\"];\n"; }
#            printf("\"%s\" [ label = \"%s",nodes[1],nodes[1]);
#            lastNode = nodes[1];
#        }
#        printf(" | <%s> %s",nodes[2],nodes[2]);
#    }
#    print "\"\n\tshape = \"record\"];\n\n";



    for (nodeelement in nodeDef) {
        printf("\"%s\" [ label = \"%s",nodeelement,nodeelement);
        for (nodefield in nodeDef[nodeelement]) {
            printf(" | <%s> %s",nodefield,nodefield);
        }
        print "\"\n\tshape = \"record\"];\n";
    }



    while(edgeCount) printf edgeDef [--edgeCount];

    print "\n\n}\n";
}