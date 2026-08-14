local mainMod = "SUPER"
local terminal = "ghostty"
local fileManager = "nautilus"

-- Current workspace state tracking for bounded non-cycling navigation
local current_ws = 1

local function nav_workspace(delta)
	current_ws = math.max(1, math.min(8, current_ws + delta))
	hl.dispatch(hl.dsp.focus({ workspace = current_ws }))
end

local function move_window_workspace(delta)
	current_ws = math.max(1, math.min(8, current_ws + delta))
	hl.dispatch(hl.dsp.window.move({ workspace = current_ws }))
end

-- Applications / Shell Binds
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal .. " +new-window"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("helium-browser-bin"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("gtk-launch org.gnome.gitlab.cheywood.Buffer"))

-- Custom Basebone Setup
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("screen_ocr"))
hl.bind(mainMod .. " + CTRL + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(os.getenv("HOME") .. "/scripts/rofi/utilities.sh"))
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd("vicinae vicinae://launch/core/search-emojis"))

-- UI Controls
hl.bind("ALT + Space", hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))

-- Window Management (Scrolling Layout specific)
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.layout("fit active"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.cycle_next({ floating = true }))

-- Focus Navigation (HJKL / Arrows)
hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Moving Windows (Niri layout equivalent swap column/stack)
hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + Up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + Down", hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Column Management (Consume / Expel)
hl.bind(mainMod .. " + bracketleft", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mainMod .. " + bracketright", hl.dsp.layout("consume_or_expel next"))

-- Column resizing presets and manual width adjustments
hl.bind(mainMod .. " + R", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.layout("fit expand"))
hl.bind(mainMod .. " + C", hl.dsp.layout("fit active"))

hl.bind(mainMod .. " + Minus", hl.dsp.layout("colresize -0.1"))
hl.bind(mainMod .. " + Equal", hl.dsp.layout("colresize +0.1"))

-- Monitor navigation and movements
hl.bind(mainMod .. " + CTRL + Left", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + Right", hl.dsp.focus({ monitor = "r" }))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ monitor = "l" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ monitor = "r" }))

hl.bind(mainMod .. " + SHIFT + CTRL + Left", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + CTRL + Right", hl.dsp.window.move({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + CTRL + H", hl.dsp.window.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + CTRL + L", hl.dsp.window.move({ monitor = "r" }))

-- Bounded Non-Cycling Workspace Navigation
hl.bind(mainMod .. " + Page_Down", function()
	nav_workspace(1)
end)
hl.bind(mainMod .. " + Page_Up", function()
	nav_workspace(-1)
end)
hl.bind(mainMod .. " + U", function()
	nav_workspace(1)
end)
hl.bind(mainMod .. " + I", function()
	nav_workspace(-1)
end)

hl.bind(mainMod .. " + CTRL + Down", function()
	move_window_workspace(1)
end)
hl.bind(mainMod .. " + CTRL + Up", function()
	move_window_workspace(-1)
end)
hl.bind(mainMod .. " + CTRL + U", function()
	move_window_workspace(1)
end)
hl.bind(mainMod .. " + CTRL + I", function()
	move_window_workspace(-1)
end)

-- Numbered Workspace bindings (1 to 8)
for i = 1, 8 do
	hl.bind(mainMod .. " + " .. i, function()
		current_ws = i
		hl.dispatch(hl.dsp.focus({ workspace = i }))
	end)
	hl.bind(mainMod .. " + SHIFT + " .. i, function()
		current_ws = i
		hl.dispatch(hl.dsp.window.move({ workspace = i }))
	end)
end

-- Mouse Bindings
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio and Brightness keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

require("nandoroid")
