param nRows;
set sorok:=1..nRows;
param cashierCount;
set penztarok:= 1..cashierCount;
param cashierLength;
set ProductGroups;
param space{ProductGroups};

var sorhossz{sorok};
var ottvane{sorok,ProductGroups} binary;
var kasszas{penztarok,sorok} binary;
var epulethossz;


#s.t.
s.t. EgySorEgyPenztaros{p in penztarok}:
    sum{s in sorok} kasszas[p, s] = 1;

s.t. EgyTermekEgySorban{p in ProductGroups}:
    sum{s in sorok} ottvane[s, p] = 1;

s.t. Maxhossz{s in sorok}:
    sorhossz[s] >= sum{p in ProductGroups} ottvane[s, p] * space[p] + sum{p in penztarok} kasszas[p, s] * cashierLength;

s.t. LeghosszabbSor{s in sorok}:
    epulethossz >= sorhossz[s];

#min/max
minimize leghosszabbsor:
    epulethossz;

solve;
printf "%f\n",epulethossz;

