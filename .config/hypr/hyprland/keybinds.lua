--------------------
---   PROGRAMS   ---
--------------------

local terminal = "kitty"
local fileManager = "nautilus"
local editor = "code"
local browser = "firefox"


-------------------
--- KEYBINDINGS ---
-------------------


local mainMod = "SUPER"


-- Application shortcuts
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd("uwsm app -- " .. terminal))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd("uwsm app -- " .. terminal, { float = true, size = { 700, 400 }, move = { "(monitor_w*0.6)", "(monitor_h*0.1)" } }))

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- " .. fileManager))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("uwsm app -- " .. editor))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm app -- " .. browser))

hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("rofi -modi emoji -show emoji"))

hl.bind(ALT .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("rofi -modi \"clipboard:greenclip print\" -show clipboard -run-command '{cmd}'"))

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))


-- Change wallpaper
hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd("~/.config/bin/change-wall.sh ~/Pictures/Wallpapers"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/bin/wall-selector.sh ~/Pictures/Wallpapers"))


-- Toggle Waybar
hl.bind(mainMod .. "+ CONTROL + B", hl.dsp.exec_cmd("killall waybar || uwsm app -- waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/styles.css"))

-- Toggle Microphone
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("~/.config/bin/mic-control.sh m"))

-- Start recording a selected area
hl.bind(mainMod .. " + CONTROL + R", hl.dsp.exec_cmd([[sh -c 'wf-recorder -g "$(slurp)" -f ~/Videos/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4']]))
-- Stop recording
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("killall wf-recorder"))



-- Sessions and power
-- Lock the current session
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))

-- Open logout/power menu
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.config/bin/logout-launch.sh"))

-- Toggle display on/off (works even on lock screen)
hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd("hyprctl dispatch dpms toggle"), { locked = true })

-- Suspend the system (works even on lock screen)
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })


-- Screenshots
-- fullscreen
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m output -t 1500 -o ~/Pictures/Screenshots -f $(date +%F_%H-%M-%S)_hyprshot.png"))

-- region selection
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region -t 1500 -o ~/Pictures/Screenshots -f $(date +%F_%H-%M-%S)_hyprshot.png"))

-- region select with satty annotation
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -d)" -t ppm - | satty --filename - --actions-on-enter save-to-clipboard,save-to-file,exit'))


-- Zoom
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(awk \"BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.3}\")"), { repeating = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(awk \"BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.5}\")"), { non_consuming = true })
hl.bind(mainMod .. " + mouse_up", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor $(awk \"BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') - 0.5}\")"), { non_consuming = true })
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("hyprctl keyword cursor:zoom_factor 1.0"))


-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + D", hl.dsp.layout("togglesplit"))     -- dwindle
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.pseudo())    -- dwindle
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + S", hl.dsp.window.pin())

-- Maximize the active window (toggle)
hl.bind(mainMod .. " + A", hl.dsp.window.fullscreen({ mode = "maximized" }))
-- Toggle true fullscreen (F11)
hl.bind("F11", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
-- Toggle true fullscreen (alternative keybind)
hl.bind(mainMod .. " + ALT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)


-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))


-- Resize with mainMod + ALT + arrow keys
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.resize({ x = 24, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.resize({ x = -24, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.resize({ x = 0, y = -24, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.resize({ x = 0, y = 24, relative = true }), { repeating = true })


-- Move windows with mainMod + SHIFT + arrow keys
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d" }))


-- Switch workspaces with mainMod + [0-9]
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))


-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 9 do
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))


-- Special workspace (scratchpad)
hl.bind(mainMod .. " + TAB", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.window.move({ workspace = "special:scratchpad" }))


-- Scroll through existing workspaces with mainMod + scroll
-- hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
-- hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))


-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("~/.config/bin/volume-control.sh d"), { repeating = true, locked = true })
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("~/.config/bin/volume-control.sh i"), { repeating = true, locked = true })
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true, locked = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/bin/volume-control.sh d"), { repeating = true, locked = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/bin/volume-control.sh i"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/bin/volume-control.sh m"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("~/.config/bin/mic-control.sh m"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/bin/brightness-control.sh -o d"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/bin/brightness-control.sh -o i"), { repeating = true, locked = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })