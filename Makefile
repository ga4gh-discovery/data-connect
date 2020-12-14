run: build_api_docs
	cd hugo && hugo serve -D
build: build_api_docs
	cd hugo && hugo --minify -d ../docs/ 
build_api_docs:
	redoc-cli bundle spec/search-api.yaml
	mv ./redoc-static.html ./hugo/content/api/index.html


	
