param nRows;
param cashierCount;
param cashierLength;

set ProductGroups;
param space{ProductGroups};


set sorok := 1..nRows;
set kasszak := 1..cashierCount;

var sorHossza{sorok} >= 0;
var sorbanPenztar{sorok, kasszak} binary;
var sorbanTermek{sorok, ProductGroups} binary;
var megoldas >= 0;


s.t. sorHosszanakKiszamitasa{s in sorok}:
	sorHossza[s] = sum{p in ProductGroups} sorbanTermek[s,p]*space[p] + sum{k in kasszak} sorbanPenztar[s,k]*cashierLength;
	
s.t. egyTermekEgySorbanLehetCsak{p in ProductGroups}:
	sum{s in sorok} sorbanTermek[s,p]=1;

s.t. kasszatSorokbaFixalni{k in kasszak}:
	sum{s in sorok} sorbanPenztar[s,k]=1;

s.t. megoldasAruhazHossza{s in sorok}:
	megoldas >= sorHossza[s];


minimize megoldasMilyenHosszuAzEpulet: megoldas;

solve;
printf "%f\n", megoldas;

