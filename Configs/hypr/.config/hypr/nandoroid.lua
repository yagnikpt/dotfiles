-- ─────────────────────────────────────────────────────────────────────────────
--  Nandoroid Shell: Keybinds & Layer Rules
--  Sourced automatically by hyprland.conf
-- ─────────────────────────────────────────────────────────────────────────────

local nandoroid = "quickshell -c nandoroid ipc call"
local scripts = "~/.config/quickshell/nandoroid/scripts"

-- ─────────────────────────────────────────────────────────────────────────────
--  Panel Toggles (via CLI)
-- ─────────────────────────────────────────────────────────────────────────────
-- Tapping Super opens Spotlight
hl.bind("SUPER + Space", hl.dsp.exec_cmd(nandoroid .. " spotlight toggle"), { release = true })

-- hl.bind("SUPER + Space", hl.dsp.exec_cmd(nandoroid .. " launcher toggle"))
hl.bind("CTRL + SUPER + T", hl.dsp.exec_cmd(nandoroid .. " quickwallpaper toggle"))
hl.bind("SUPER + A", hl.dsp.exec_cmd(nandoroid .. " notifications toggle"))
hl.bind("SUPER + N", hl.dsp.exec_cmd(nandoroid .. " quicksettings toggle"))
hl.bind("SUPER + G", hl.dsp.exec_cmd(nandoroid .. " quickactions toggle"))
hl.bind("SUPER + D", hl.dsp.exec_cmd(nandoroid .. " dashboard toggle"))
hl.bind("SUPER + Comma", hl.dsp.exec_cmd(nandoroid .. " settings toggle"))
hl.bind("SUPER + Tab", hl.dsp.exec_cmd(nandoroid .. " overview toggle"))
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd(nandoroid .. " systemmonitor toggle"))
hl.bind("SUPER + X", hl.dsp.exec_cmd(nandoroid .. " session toggle"))

-- ─────────────────────────────────────────────────────────────────────────────
--  Utility & Power
-- ─────────────────────────────────────────────────────────────────────────────
hl.bind("CTRL + SUPER + R", hl.dsp.exec_cmd(scripts .. "/restartshell.sh"))

-- ─────────────────────────────────────────────────────────────────────────────
--  Brightness & OSD
-- ─────────────────────────────────────────────────────────────────────────────
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd(nandoroid .. " brightness increment"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(nandoroid .. " brightness decrement"),
	{ locked = true, repeating = true }
)

-- ─────────────────────────────────────────────────────────────────────────────
--  Layer Rules
-- ─────────────────────────────────────────────────────────────────────────────
hl.config({
	layerrule = {
		"blur, quickshell:.*",
		"ignore_alpha 0.79, quickshell:.*",
		"blur, notifications",
		"ignore_alpha 0.69, notifications",
		"blur, launcher",
		"ignore_alpha 0.5, launcher",
		"no_anim, overview",
		"blur, session",

		-- Instantly show region tools
		"no_anim, quickshell:regionSelector",
		"blur off, quickshell:regionSelector",
		"no_anim, quickshell:recordingMarker",
		"blur off, quickshell:recordingMarker",
	},
})
