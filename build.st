"prepare"
EpMonitor current disable.
Iceberg remoteTypeSelector: #httpsUrl.
"remove baseline to allow a proper load"
#BaselineOfMicrodown asPackage removeFromSystem.
{ 
	{ 'github://estebanlm/Microdown:v1/src'. 'Microdown'. 'Macrodown' }.
	{ 'github://estebanlm/foliage:v1.4/src'. 'Foliage'. 'Publisher' }.
} do: [ :each |
	[ 
		Metacello new
			ignoreImage;
			onConflict: [ :e | e useIncoming ];
			onUpgrade: [ :e | e useIncoming ];
			repository: each first;
			baseline: each second;
			load: each third.
		Metacello new baseline: each second; lock. 
	] 
	on: Warning 
	do: [ :w | w resume ] 
]
