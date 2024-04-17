function onFeatureChange() as Void
    featureFlagKey = "sample-feature"

    value = m.ld.variation(featureFlagKey, false)

    if value then
      m.top.backgroundColor = &h00844BFF
      m.evaluation.text = "The " + featureFlagKey + " feature flag evaluates to true"
    else
      m.top.backgroundColor = &h373841FF
      m.evaluation.text = "The " + featureFlagKey + " feature flag evaluates to false"
    end if
end function

function onStatusChange() as Void
    if m.ld.status.getStatus() = m.ld.status.map.initialized
      m.status.text = "SDK successfully initialized"
    else
      m.status.text = "SDK failed to initialize. Please check your internet connection and SDK credential for any typo."
    end if
end function

function init() as Void
    mobileKey = ""

    launchDarklyNode = m.top.findNode("launchDarkly")
    launchDarklyNode.observeField("flags", "onFeatureChange")
    launchDarklyNode.observeField("status", "onStatusChange")

    config = LaunchDarklyConfig(mobileKey, launchDarklyNode)

    ' Set up the user-kind context properties. This context should appear on
    ' your LaunchDarkly contexts dashboard soon after you run the demo.
    context = LaunchDarklyCreateContext({kind: "user", key: "example-user-key", name: "Sandy"})

    LaunchDarklySGInit(config, context)

    m.ld = LaunchDarklySG(launchDarklyNode)

    m.evaluation = m.top.findNode("evaluation")
    m.evaluation.font.size=40
    m.evaluation.color="0xFFFFFFFF"

    m.status = m.top.findNode("status")
    m.status.font.size=20
    m.status.color="0xFFFFFFFF"

    m.top.backgroundColor = &h373841FF
    m.top.backgroundUri = ""

    onFeatureChange()
end function
