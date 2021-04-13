run: build_api_docs
	echo "start run"
	cd hugo && hugo serve -D
build: build_api_docs
	echo "start doc build"
	git submodule update --init --recursive
	echo "start hugo build"
	cd hugo && hugo --minify -d ../built_docs/ 
	echo "end build"
build_prod: build_api_docs
	echo "start prod doc build"
	echo -e "\033[33mUSE MAKE BUILD FOR TESTING LOCALLY, DON'T TRACK docs/!\033[0m"
	git submodule update --init --recursive
	echo "start hugo build"
	cd hugo && hugo --minify -d ../docs/ 
	echo "end prod build"
build_api_docs:
	echo "start api docs build"
	redoc-cli bundle spec/api.yaml
	mkdir -p `dirname ./hugo/content/api/index.html`  
	mv ./redoc-static.html ./hugo/content/api/index.html
clean:
	rm -rf hugo/docs/ docs/ built_docs/ hugo/built_docs/ hugo/content/api/index.html
