#Makefile

SILENT=-Dsilent

compile:
	openfl build project.xml flash --no-traces $(SILENT)
	cp bin/flash/bin/Main.swf 4d.swf

info:
	openfl build project.xml flash --no-traces -Dinfo $(SILENT)
	cp bin/flash/bin/Main.swf 4d.swf

debug:
	openfl build project.xml flash -debug $(SILENT)
	cp bin/flash/bin/Main.swf 4d.swf

cpp:
	openfl test project.xml cpp -debug 

run:
	chromium 4d.html &

