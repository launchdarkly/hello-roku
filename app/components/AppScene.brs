function onFeatureChange() as Void
    value = m.ld.variation("YOUR FLAG KEY HERE", false)
    print "evaluation: " value

    if value then
        m.featureStatus.text = "feature is launched"
    else
        m.featureStatus.text = "feature is hidden"
    end if
end function

function onStatusChange () as Void
    status = m.ld.status.getStatusAsString()
    print "status: " status

    m.clientStatus.text = "client status: " + status
end function

function init() as Void
    launchDarklyNode = m.top.findNode("launchDarkly")

    config = LaunchDarklyConfig("YOUR MOBILE KEY HERE", launchDarklyNode)
    config.setLogLevel(LaunchDarklyLogLevels().debug)

    user = LaunchDarklyUser("user-key")

    LaunchDarklySGInit(config, user)

    m.ld = LaunchDarklySG(launchDarklyNode)

    m.featureStatus = m.top.findNode("featureStatus")
    m.featureStatus.font.size=92
    m.featureStatus.color="0x72D7EEFF"

    m.clientStatus = m.top.findNode("clientStatus")

    launchDarklyNode.observeField("flags", "onFeatureChange")
    launchDarklyNode.observeField("clientStatus", "onStatusChange")

    onFeatureChange()
    onStatusChange()
end function
