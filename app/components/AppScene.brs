' Before running this example, please
'
' 1. Specify your preferred flag by setting featureFlagKey
' 2. Specify your mobile key by setting mobileKey

function onFeatureChange() as Void
    ' TODO: Set featureFlagKey to the feature flag key you want to evaluate.
    featureFlagKey = "my-boolean-flag"

    value = m.ld.variation(featureFlagKey, false)
    print "evaluation: " value

    if value then
        m.featureStatus.text = "Feature flag " + featureFlagKey + " is true for this context"
    else
        m.featureStatus.text = "Feature flag " + featureFlagKey + " is false for this context"
    end if
end function

function onStatusChange() as Void
    status = m.ld.status.getStatusAsString()
    print "status: " status

    m.clientStatus.text = "client status: " + status
end function

function init() as Void
    ' TODO: Set mobileKey to your LaunchDarkly mobile key.
    mobileKey = ""

    launchDarklyNode = m.top.findNode("launchDarkly")

    config = LaunchDarklyConfig(mobileKey, launchDarklyNode)
    config.setLogLevel(LaunchDarklyLogLevels().debug)

    ' Set up the user-kind context properties. This context should appear on
    ' your LaunchDarkly contexts dashboard soon after you run the demo.
    context = LaunchDarklyCreateContext({kind: "user", key: "example-user-key", name: "Sandy"})

    LaunchDarklySGInit(config, context)

    m.ld = LaunchDarklySG(launchDarklyNode)

    m.featureStatus = m.top.findNode("featureStatus")
    m.featureStatus.font.size=92
    m.featureStatus.color="0x72D7EEFF"

    m.clientStatus = m.top.findNode("clientStatus")

    launchDarklyNode.observeField("flags", "onFeatureChange")
    launchDarklyNode.observeField("status", "onStatusChange")

    onFeatureChange()
    onStatusChange()
end function
