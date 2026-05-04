-- Browser router: fn-click → Chrome, otherwise → Firefox.
-- Set Hammerspoon as default browser in System Settings → Desktop & Dock.

local DEFAULT_BROWSER = "org.mozilla.firefox"
local FN_BROWSER      = "com.google.Chrome"

-- Allow Fn+Click link to open in Chrome (replaces Vejla app)
hs.urlevent.httpCallback = function(_scheme, _host, _params, fullURL)
  local mods = hs.eventtap.checkKeyboardModifiers()
  local bundleID = mods.fn and FN_BROWSER or DEFAULT_BROWSER
  hs.urlevent.openURLWithBundle(fullURL, bundleID)
end

hs.alert.show("Browser router loaded")
