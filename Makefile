build: $(shell find app/ -type f) copyLibrary
	rm -f app.zip
	cd app && zip ../app.zip -r ./*

package.zip:
	./fetch.sh

package: package.zip
	rm -rf package
	unzip package.zip

copyLibrary: package
	rm -f app/components/LaunchDarkly/*
	rm -f app/source/LaunchDarkly/*
	cp package/LaunchDarkly.brs app/source/
	cp package/LaunchDarklyTask.brs app/components/
	cp package/LaunchDarklyTask.xml app/components/

clean:
	rm -rf package.zip app.zip package app/components/LaunchDarkly* app/source/LaunchDarkly*
