package.zip:
	LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/launchdarkly/roku-client-sdk/releases/latest)
	LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
	ARTIFACT_URL="https://github.com/account/project/releases/download/$(LATEST_VERSION)/package.zip"
	curl $(ARTIFACT_URL) -o package.zip

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
	cd app && zip ../app.zip -r ./*

clean:
	rm -rf app.zip package app/components/LaunchDarkly* app/source/LaunchDarkly*
