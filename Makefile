run: build_api_docs
	echo "start run"
	cd hugo && hugo serve -D
build: build_api_docs
	echo "start doc build"
	git submodule update --init --recursive
	echo "start hugo build"
	cd hugo && hugo --minify -d ../docs/ 
	echo "end build"
build_api_docs:
	echo "start api docs build"
	redoc-cli bundle spec/search-api.yaml
	mv ./redoc-static.html ./hugo/content/api/index.html
clean:
	rm -r docs/
