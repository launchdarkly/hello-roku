package: package.zip
	rm -rf package
	unzip package.zip

copyLibrary: package
	rm -f app/components/LaunchDarkly/*
	rm -f app/source/LaunchDarkly/*
	cp package/LaunchDarkly.brs app/source/
	cp package/LaunchDarklyTask.brs app/components/
	cp package/LaunchDarklyTask.xml app/components/

build: $(shell find app/ -type f) copyLibrary
	rm -f app.zip
	zip -r app.zip app/
