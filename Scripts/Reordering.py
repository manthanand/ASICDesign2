import re

class Node:
   def __init__(self, dataval=None, prevval=None, nextval=None):
        self.dataval = dataval
        self.prevval = prevval 
        self.nextval = nextval

# For Scan Chain In
scanlist = [1]
i = 0
scan_out_node = ""
scan_in_node = ""
node_name = ""
with open ("scaninreordered.v", "r") as f:
    for x in f:
        if (i == 0): scan_in_node = x.split(".Si(",1)[1][:-3]
        if (i == 4): scan_out_node = x.split(".So(",1)[1][:-3]
        if (i == 5): 
            node_name = x.split(".Din_DUT(",1)[1][:-4]
            if (scan_in_node == "scan_in"): scanlist[0] = Node(node_name, scan_in_node, scan_out_node)
            else: scanlist.append(Node(node_name, scan_in_node, scan_out_node))
        i = (i + 1) % 6

currNode = scanlist[0]
scanlist.pop(0)
nets = [currNode.dataval]

while(len(scanlist)):
    for i in scanlist:
        if (i.prevval == currNode.nextval):
            nets.append(i.dataval)
            scanlist.remove(i)
            currNode = i

fwrite = open("SCAN_REG_UPDATED.v", "w")
for i in range(len(nets)): fwrite.write(f"    assign SCAN_IN_REG[{263 - i}] = {nets[i]};\n")

fwrite.write("\n")

# For Scan Chain Out
scanlist = [1]
i = 0
scan_out_node = ""
scan_in_node = ""
node_name = ""
with open ("scanoutreordered.v", "r") as f:
    for x in f:
        if (i == 0): node_name = x.split(".Dout_DUT(",1)[1][:-3]
        if (i == 1): scan_in_node = re.findall(r"scan_\d+", x.split(".Si(",1)[1][:-3])[0]
        if (i == 4): 
            scan_out_node = x.split(".So(",1)[1][:-4]
            if (scan_out_node == "scan_out"): scanlist[0] = Node(node_name, scan_in_node, scan_out_node)
            else: scanlist.append(Node(node_name, scan_in_node, scan_out_node))
            # print(scan_in_node, scan_out_node, node_name)
        i = (i + 1) % 5

currNode = scanlist[0]
scanlist.pop(0)
nets = [currNode.dataval]

while(len(scanlist)):
    for i in scanlist:
        if (i.nextval == currNode.prevval):
            nets.insert(0, i.dataval)
            scanlist.remove(i)
            currNode = i

for i in range(len(nets)): fwrite.write(f"    assign {nets[i]} = SCAN_OUT_REG[{127 - i}];\n")
fwrite.close()