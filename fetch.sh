#!/bin/sh
# script from https://blog.markvincze.com/download-artifacts-from-a-latest-github-release-in-sh-and-powershell/
set -e
curl -L -o package.zip https://github.com/launchdarkly/roku-client-sdk/releases/download/1.0.0-beta.2/package.zip
