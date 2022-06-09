# LaunchDarkly Sample Roku Application
We've built a simple application that demonstrates how LaunchDarkly's SDK works. 

Below, you'll find the basic build procedure, but for more comprehensive instructions, you can visit your [Quickstart page](https://app.launchdarkly.com/quickstart#/) or the [Roku reference guide](https://docs.launchdarkly.com/sdk/client-side/roku).

## Build instructions
1. Edit `app/components/AppScene.brs` and set the value of `mobileKey` to your LaunchDarkly mobile SDK key. If there is an existing boolean feature flag in your LaunchDarkly project that you want to evaluate, set `featureFlagKey` to the flag key.

```brightscript
featureFlagKey = "my-boolean-flag"

mobileKey = "1234567890abcdef"
```

2. On the command line, run `make`.
3. Upload `app.zip` to your device.

You should receive the message "Feature flag '<flag key>' is <true/false> for this user".