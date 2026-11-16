function onFeatureChange() as Void
    featureFlagKey = "sample-feature"

    value = m.ld.variation(featureFlagKey, false)

    if value then
      animateTo(&h00844BFF, 1.0)
      m.evaluation.text = "The " + featureFlagKey + " feature flag evaluates to true"
    else
      animateTo(&h373841FF, 0.0)
      m.evaluation.text = "The " + featureFlagKey + " feature flag evaluates to false"
    end if
end function

' Fade the background to the color and the logo to the opacity.
function animateTo(color as Integer, logoOpacity as Float) as Void
    m.backgroundAnimation.control = "stop"
    m.backgroundInterpolator.keyValue = [m.background.color, color]
    m.backgroundAnimation.control = "start"

    m.logoAnimation.control = "stop"
    m.logoInterpolator.keyValue = [m.logo.opacity, logoOpacity]
    m.logoAnimation.control = "start"
end function

function onStatusChange() as Void
    status = m.ld.status.getStatus()

    if status = m.ld.status.map.initialized
      m.statusDot.blendColor = &h7CF29CFF
      m.status.text = "SDK successfully initialized"
    else if status = m.ld.status.map.unauthorized
      m.statusDot.blendColor = &hFF6B6BFF
      m.status.text = "SDK failed to initialize. Please check your mobile key for any typo."
    else
      m.statusDot.blendColor = &hFF6B6BFF
      m.status.text = "SDK failed to initialize. Please check your internet connection and SDK credential for any typo."
    end if
end function

function init() as Void
    mobileKey = ""

    m.background = m.top.findNode("background")
    m.logo = m.top.findNode("logo")
    m.evaluation = m.top.findNode("evaluation")
    m.status = m.top.findNode("status")
    m.statusDot = m.top.findNode("statusDot")
    m.backgroundAnimation = m.top.findNode("backgroundAnimation")
    m.backgroundInterpolator = m.top.findNode("backgroundInterpolator")
    m.logoAnimation = m.top.findNode("logoAnimation")
    m.logoInterpolator = m.top.findNode("logoInterpolator")

    if mobileKey = "" then
      m.statusDot.blendColor = &hFF6B6BFF
      m.evaluation.text = "Set mobileKey in app/components/AppScene.brs"
      m.status.text = "No mobile key is set"
      return
    end if

    launchDarklyNode = m.top.findNode("launchDarkly")
    launchDarklyNode.observeField("flags", "onFeatureChange")
    launchDarklyNode.observeField("status", "onStatusChange")

    config = LaunchDarklyConfig(mobileKey, launchDarklyNode)

    ' Set up the user-kind context properties. This context should appear on
    ' your LaunchDarkly contexts dashboard soon after you run the demo.
    contextProperties = {kind: "user", key: "example-user-key", name: "Sandy"}
    context = LaunchDarklyCreateContext(contextProperties)

    m.top.findNode("context").text = "Evaluating for " + contextProperties.kind + " " + chr(34) + contextProperties.key + chr(34) + " (" + contextProperties.name + ")"

    LaunchDarklySGInit(config, context)

    m.ld = LaunchDarklySG(launchDarklyNode)

    onFeatureChange()
end function
