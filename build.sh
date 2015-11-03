#!/bin/sh

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



OPTION=$1

case "$OPTION" in
   "ALL") echo "Full build system is initializing ..." 
		  allBuild	
   ;;
   "LOCAL") echo "Local build system is initializing ..." 
		    localBuild	
   ;;
   "DEV") echo "Dev build system is initializing ..."
		  devBuild	
   ;;
   "API-DATA") echo "Api-data.json build system is initializing ..."
			   apiDataJson
   ;;
   "TOC") echo "Table-Of-Content build system is initializing ..."
			   buildTocHtml
   ;;
   "CFP") echo "File permission is changing ..."
			   filePermission
   ;;
esac

