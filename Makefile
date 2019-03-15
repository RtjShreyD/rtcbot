.PHONY: clean test phony 

# Empty rule for forcing rebuilds
phony:


js: phony
	cd js; npm run build
	cp js/dist/rtcbot.umd.js rtcbot/rtcbot.js

dist: js phony
	rm -rf ./dist
	python setup.py sdist bdist_wheel

upload: dist phony
	cd js; npm publish
	twine upload dist/*

test: phony
	nosetests --with-coverage --cover-package=rtcbot --cover-html
	cd js; npm run test

docs: phony
	cd docs; make html

clean: phony
	rm -rf ./dist
	rm -rf ./js/dist
	rm -f ./rtcbot/rtcbot.js
	rm -rf ./docs/_build