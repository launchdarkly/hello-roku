# LaunchDarkly sample BrightScript application

We've built a simple Roku application that demonstrates how LaunchDarkly's SDK works.

Below, you'll find the build procedure. For more comprehensive instructions, you can visit your [Quickstart page](https://app.launchdarkly.com/quickstart#/) or the [BrightScript reference guide](https://docs.launchdarkly.com/sdk/client-side/roku).

## Build instructions

1. Set the value of `mobileKey` to your LaunchDarkly mobile key. If there is an existing boolean feature flag in your LaunchDarkly project that you want to evaluate, set `featureFlagKey` to the flag key.

```brightscript
function onFeatureChange() as Void
    featureFlagKey = "hello-ios-boolean"
    ' ... snip
end function

function init() as Void
    mobileKey = "mob-9dd0237c-ba5e-4ccd-903a-5b5703ea85d5"
    ' ... snip
end function
```

2. On the command line, run `make` to generate the installable `app.zip` file.

3. Upload `app.zip` to your Roku device.

You should receive the message "The <flagKey> feature flag evaluates to <flagValue>.", the application will run continuously and react to the flag changes in LaunchDarkly.
