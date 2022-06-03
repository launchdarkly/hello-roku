// Set featureFlagKey to the feature flag key you want to evaluate.
featureFlagKey = "my-boolean-flag"

// Set mobileKey to your LaunchDarkly mobile key.
mobileKey = ""

function onFeatureChange() as Void
    value = m.ld.variation(featureFlagKey, false)
    print "evaluation: " value

    if value then
        m.featureStatus.text = "Feature flag " + featureFlagKey + " is true for this user"
    else
        m.featureStatus.text = "Feature flag " + featureFlagKey + " is false for this user"
    end if
end function

function onStatusChange() as Void
    status = m.ld.status.getStatusAsString()
    print "status: " status

    m.clientStatus.text = "client status: " + status
end function

function init() as Void
    launchDarklyNode = m.top.findNode("launchDarkly")
    
    config = LaunchDarklyConfig(mobileKey, launchDarklyNode)
    config.setLogLevel(LaunchDarklyLogLevels().debug)
  
    // Set up the user properties. This user should appear on your LaunchDarkly users dashboard
    // soon after you run the demo.
    user = LaunchDarklyUser("example-user-key")
    user.setName("Sandy")

    LaunchDarklySGInit(config, user)
    // TKTK initialization success/failure messages needed.
    
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
