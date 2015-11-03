#!/bin/sh

#This is a shell script which help us to run several build command for Dev center in one place.

# How to run this script ?
# To initialize the build , try to run this command from terminal within paradocs folder

# sh ./build.sh _command_
# for example sh ./build.sh ALL

# List of available commands

# 1. ALL-  complete dev center build Process.
# 2. DEV -  build for FusioncCharts
# 3. LOCAL - build for Local System
# 4. API-DATA - generate api-data.json
# 5. TOC - to generate table of content base on baseurl in _config.yml file.
# 6. CFP - to change file permission of out folder to 777


allBuild ()
{
	apiDataJson
	buildTocHtml
	sudo jekyll serve
	echo "Finish ALL_BUILD!!"
}

localBuild ()
{
	buildTocHtml
	sudo jekyll serve
	echo "Finish LOCAL_BUILD!!"
}

devBuild ()
{
	baseUrl_dev
	buildTocHtml
	sudo jekyll build
	cd ..
	filePermission
	baseUrl_paradocs
	sudo gulp
	echo "Finish DEV_BUILD!!"
}

buildTocHtml ()
{
	cd jekyll/ 
	sudo node utils/buildTocHtml.js
	echo "Finish BUILD_TOC!!"
}

apiDataJson ()
{
	./node_modules/jsdoc/jsdoc -c config.json
	echo "Finish API_DATA!!"; 
}

filePermission ()
{
	sudo chmod 777 -R jekyll/out/
	echo "Finish FILE_PERMISSION!!";
}

baseUrl_dev ()
{
	VAR_1='\/paradocs\/jekyll\/out\/'
	VAR_2='\/dev\/'
	VAR_3='0,/'$VAR_1'/{s/'$VAR_1'/'$VAR_2'/}'
	sed -i -e $VAR_3 jekyll/_config.yml
	echo "base url change to /dev/"
}

baseUrl_paradocs ()
{	
	VAR_1='\/dev\/'
	VAR_2='\/paradocs\/jekyll\/out\/'
	VAR_3='0,/'$VAR_1'/{s/'$VAR_1'/'$VAR_2'/}'
	sed -i -e $VAR_3 jekyll/_config.yml
	echo "base url change to /paradocs/jekyll/out/"
}


scriptMessage ()
{
	echo "\n\nsudo sh ./build.sh _command_\n"
	echo "\nList of available commands"
	echo "\ncommnad   -   description"
	echo "\nALL -  complete dev center build Process."
	echo "\nDEV -  build for FusioncCharts"
	echo "\nLOCAL - build for Local System"
	echo "\nAPI-DATA - generate api-data.json"
	echo "\nTOC - to generate table of content base on baseurl in _config.yml file."
	echo "\nCFP - to change file permission of out folder to 777\n\n\n\n"
}

OPTION=$1

case "$OPTION" in
   "ALL") echo "\nFull build system is initializing ..." 
		  allBuild	
   ;;
   "LOCAL") echo "\nLocal build system is initializing ..." 
		    localBuild	
   ;;
   "DEV") echo "\nDev build system is initializing ..."
		  devBuild	
   ;;
   "API-DATA") echo "\nApi-data.json build system is initializing ..."
			   apiDataJson
   ;;
   "TOC") echo "\nTable-Of-Content build system is initializing ..."
			   buildTocHtml
   ;;
   "CFP") echo "\nFile permission is changing ..."
			   filePermission
   ;;
   *) echo "\nInvalid command .."
			scriptMessage
			   
   ;;
esac

