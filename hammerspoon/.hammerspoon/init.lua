--------------------------------------------------------------------------------
-- Browser routing
--
-- Set Hammerspoon as the default browser.
-- Open links in Firefox by default, or Chrome when Fn is held.
--------------------------------------------------------------------------------

local DEFAULT_BROWSER = "org.mozilla.firefox"
local FN_BROWSER      = "com.google.Chrome"

hs.urlevent.httpCallback = function(_scheme, _host, _params, fullURL)
    local mods = hs.eventtap.checkKeyboardModifiers()
    local bundleID = mods.fn and FN_BROWSER or DEFAULT_BROWSER
    hs.urlevent.openURLWithBundle(fullURL, bundleID)
end


--------------------------------------------------------------------------------
-- Spaces
--
-- Ctrl + Alt + Shift + ← → moves the focused window between macOS Spaces
-- and follows the window to the destination Space.
--------------------------------------------------------------------------------

local spaces = require("hs.spaces")

local function moveWindowToAdjacentSpace(direction)
    local win = hs.window.focusedWindow()
    if not win then return end

    local currentSpace = spaces.windowSpaces(win:id())[1]
    if not currentSpace then return end

    local screen = win:screen()
    local uuid = screen:spacesUUID()
    local spaceList = spaces.layout()[uuid]

    local currentIndex
    for i, spaceId in ipairs(spaceList) do
        if spaceId == currentSpace then
            currentIndex = i
            break
        end
    end

    if not currentIndex then return end

    local targetIndex = currentIndex + direction
    if targetIndex < 1 or targetIndex > #spaceList then return end

    local targetSpace = spaceList[targetIndex]

    spaces.moveWindowToSpace(win:id(), targetSpace)
    spaces.gotoSpace(targetSpace)
end

-- Move focused window to previous / next Space
hs.hotkey.bind({"ctrl", "alt", "shift"}, "Left", function()
    moveWindowToAdjacentSpace(-1)
end)

hs.hotkey.bind({"ctrl", "alt", "shift"}, "Right", function()
    moveWindowToAdjacentSpace(1)
end)


--------------------------------------------------------------------------------
-- App launcher: Escape as a leader key
--
-- Caps Lock is remapped to Escape in macOS keyboard settings, so it reaches
-- Hammerspoon as a plain Escape. We treat a bare Escape as a hold-modifier:
-- hold it and press a number to focus/launch the matching app.
--
-- Escape is a normal key, not a modifier, so we can only chord it by holding the
-- Escape event back until release. On release, if no number was pressed, we
-- re-emit a real Escape so its usual behaviour still works. Trade-off: a plain
-- (un-chorded) Escape now fires on key-release instead of key-press.
--
-- Modified Escapes (e.g. Cmd+Escape, used below for cmux) are passed straight
-- through so their own bindings keep working.
--------------------------------------------------------------------------------

local LEADER_APPS = {
    ["1"] = "org.mozilla.firefox",  -- Firefox
    ["2"] = "com.cmuxterm.app",     -- cmux
    ["3"] = "com.spotify.client",   -- Spotify
    ["4"] = "com.google.Chrome.app.loodompmajbahfonikbebnocfkmplgah", -- Caly
}

local ESCAPE_KEYCODE   = hs.keycodes.map["escape"]
local SYNTHETIC_MARKER = 0x4C454144 -- "LEAD"; tags Escapes we re-emit ourselves
local USER_DATA        = hs.eventtap.event.properties.eventSourceUserData

local escapeSwallowed   = false -- we are holding an un-modified Escape
local escapeUsedAsLeader = false -- a number was pressed during this hold

escapeLeaderTap = hs.eventtap.new(
    { hs.eventtap.event.types.keyDown, hs.eventtap.event.types.keyUp },
    function(event)
        -- Ignore the Escape events we synthesize ourselves.
        if event:getProperty(USER_DATA) == SYNTHETIC_MARKER then return false end

        local keyCode = event:getKeyCode()
        local isDown  = event:getType() == hs.eventtap.event.types.keyDown

        if keyCode == ESCAPE_KEYCODE then
            if isDown then
                -- Only engage on a bare Escape; let modified ones pass through.
                if not event:getFlags():containExactly({}) then
                    escapeSwallowed = false
                    return false
                end
                escapeSwallowed   = true
                escapeUsedAsLeader = false
                return true -- hold it back; decide on release
            else
                if not escapeSwallowed then return false end
                escapeSwallowed = false
                if not escapeUsedAsLeader then
                    -- Re-emit a real Escape so a plain tap still works.
                    for _, down in ipairs({ true, false }) do
                        local e = hs.eventtap.event.newKeyEvent({}, "escape", down)
                        e:setProperty(USER_DATA, SYNTHETIC_MARKER)
                        e:post()
                    end
                end
                return true
            end
        end

        -- A number pressed while Escape is held -> launch its app.
        if isDown and escapeSwallowed then
            for key, bundleID in pairs(LEADER_APPS) do
                if keyCode == hs.keycodes.map[key] then
                    escapeUsedAsLeader = true
                    hs.application.launchOrFocusByBundleID(bundleID)
                    return true
                end
            end
        end

        return false
    end
)
escapeLeaderTap:start()


--------------------------------------------------------------------------------
-- cmux hotkey window
--
-- Cmd + Escape shows/hides cmux, mimicking iTerm's hotkey window. cmux reads the
-- Ghostty config for fonts/themes only, so the global hotkey lives here instead.
--------------------------------------------------------------------------------

local CMUX_BUNDLE_ID = "com.cmuxterm.app"

hs.hotkey.bind({"cmd"}, "escape", function()
    local cmux = hs.application.get(CMUX_BUNDLE_ID)
    if not cmux then
        -- Only toggle an already-running cmux; never launch it.
        return
    end
    if cmux:isFrontmost() then
        cmux:hide()
    else
        cmux:activate()
    end
end)


--------------------------------------------------------------------------------
-- Tickoist quick add (Firefox)
--
-- Ctrl + Cmd + D focuses Firefox, jumps to the pinned Tickoist tab, and presses
-- `c` to open Tickoist's in-app quick-add. Gives the browser-tab setup a global
-- capture shortcut, mirroring the desktop app's Ctrl+Cmd+A.
--
-- When Tickoist is in quiet mode the UI is hidden and the first keypress only
-- wakes it, so we send a harmless wake key (backtick) first and only then `c`,
-- otherwise the quick-add shortcut gets swallowed bringing the UI back.
--------------------------------------------------------------------------------

local TICKOIST_FIREFOX_BUNDLE_ID = "org.mozilla.firefox"
local TICKOIST_TAB_INDEX         = "2" -- Cmd+<n> selects the nth Firefox tab

hs.hotkey.bind({"ctrl", "cmd"}, "d", function()
    local firefox = hs.application.get(TICKOIST_FIREFOX_BUNDLE_ID)
    if not firefox then return end -- only act when Firefox is already running

    firefox:activate()

    -- Wait until Firefox is actually frontmost before sending keys, otherwise the
    -- tab switch / quick-add could land in whatever app was focused before.
    hs.timer.waitUntil(
        function() return firefox:isFrontmost() end,
        function()
            hs.eventtap.keyStroke({"cmd"}, TICKOIST_TAB_INDEX, 0) -- select the tab
            hs.timer.doAfter(0.08, function()
                hs.eventtap.keyStroke({}, "`", 0)                 -- wake from quiet mode
                hs.timer.doAfter(0.08, function()
                    hs.eventtap.keyStroke({}, "c", 0)             -- open quick-add
                end)
            end)
        end,
        0.02 -- poll interval
    )
end)
