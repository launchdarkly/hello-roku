#!/bin/sh
# script from https://blog.markvincze.com/download-artifacts-from-a-latest-github-release-in-sh-and-powershell/
set -e
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/launchdarkly/roku-client-sdk/releases/latest)
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
ARTIFACT_URL="https://github.com/account/project/releases/download/$LATEST_VERSION/package.zip"
curl $ARTIFACT_URL -o package.zip
