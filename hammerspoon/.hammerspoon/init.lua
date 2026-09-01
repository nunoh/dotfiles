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
-- ChatGPT hotkey window
--
-- Cmd + § shows/hides ChatGPT, the same way Cmd + Escape does for cmux below.
--
-- macOS reports the key left of "1" on ISO keyboards as kVK_ISO_Section. Its
-- name in hs.keycodes.map depends on the active layout, so we fall back to the
-- raw keycode.
--------------------------------------------------------------------------------

local CHATGPT_BUNDLE_ID = "com.openai.codex" -- the ChatGPT app kept its old ID
local SECTION_KEY       = hs.keycodes.map["§"] or 10

hs.hotkey.bind({"cmd"}, SECTION_KEY, function()
    local chatgpt = hs.application.get(CHATGPT_BUNDLE_ID)
    if not chatgpt then
        hs.application.launchOrFocusByBundleID(CHATGPT_BUNDLE_ID)
        return
    end
    if chatgpt:isFrontmost() then
        chatgpt:hide()
    else
        chatgpt:activate()
    end
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
-- cmux keys: opacity toggle (Cmd+U) and alternate workspace (Cmd+Shift+1)
--
-- cmux has no native opacity-toggle action and ignores Ghostty's
-- `toggle_background_opacity` keybind, so we write a local runtime override and
-- live-reload cmux. It also has no last-workspace action, and its
-- `shortcuts.bindings` only accepts its own built-in action ids, so the
-- alternate-workspace pair is tracked by a script here instead.
--
-- We want these keys only inside cmux (Cmd+U is "underline" elsewhere).
-- A global hotkey would swallow it everywhere, so we watch key events and decide
-- per keypress, checking the frontmost app only at the moment Cmd+U is pressed.
--
-- An earlier version enabled/disabled a real hotkey from hs.application.watcher
-- instead. That desynced: apps that activate transiently disable the hotkey, and
-- cmux emits no further `activated` because it never actually lost focus, so
-- Cmd+U stayed dead until you switched away and back.
--------------------------------------------------------------------------------

local opacityScript   = os.getenv("HOME") .. "/.local/bin/cmux-opacity-toggle"
local alternateScript = os.getenv("HOME") .. "/.local/bin/cmux-alternate-workspace"
local U_KEYCODE       = hs.keycodes.map["u"]
local ONE_KEYCODE     = hs.keycodes.map["1"]
local cmuxTasks       = {}

local function runCmuxScript(script, label)
    if cmuxTasks[script] and cmuxTasks[script]:isRunning() then return end

    cmuxTasks[script] = hs.task.new(script, function(exitCode, _stdout, stderr)
        if exitCode ~= 0 then
            hs.alert.show(label .. " failed")
            print(stderr)
        end
        cmuxTasks[script] = nil
    end)

    if cmuxTasks[script] then cmuxTasks[script]:start() end
end

cmuxKeyTap = hs.eventtap.new(
    { hs.eventtap.event.types.keyDown },
    function(event)
        local code = event:getKeyCode()
        if code ~= U_KEYCODE and code ~= ONE_KEYCODE then return false end

        local flags = event:getFlags()
        local isOpacity   = code == U_KEYCODE and flags:containExactly({"cmd"})
        local isAlternate = code == ONE_KEYCODE and flags:containExactly({"cmd", "shift"})
        if not isOpacity and not isAlternate then return false end

        -- Only now is it worth asking who is frontmost.
        local app = hs.application.frontmostApplication()
        if not app or app:bundleID() ~= CMUX_BUNDLE_ID then return false end

        if isOpacity then
            runCmuxScript(opacityScript, "cmux opacity toggle")
        else
            runCmuxScript(alternateScript, "cmux alternate workspace")
        end

        return true -- cmux binds neither key itself, so swallow it
    end
)
cmuxKeyTap:start()


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
