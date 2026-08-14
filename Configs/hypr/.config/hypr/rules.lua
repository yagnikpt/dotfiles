-- Workspace Rules (matching Niri workspace definitions and persistent scrolling setup)
for i = 1, 8 do
    hl.workspace_rule({
        workspace = tostring(i),
        layout = "scrolling",
        persistent = true,
    })
end

hl.workspace_rule({
    workspace = "name:media",
    layout = "scrolling",
    persistent = true,
})

hl.workspace_rule({
    workspace = "name:space",
    layout = "scrolling",
    persistent = true,
})

-- Ignore maximize requests
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Float rules (migrated open-floating true)
hl.window_rule({
    name  = "float-utilities",
    match = { class = "^(blueman-manager|xdg-desktop-portal|zoom|Calculator|pavucontrol|speedcrunch|tlauncher|com.network.manager|dev.noctalia.Noctalia|tui)$" },
    float = true,
})

-- Workspace assignments (Niri open-on-workspace rules)
hl.window_rule({
    name  = "media-apps",
    match = { class = "^(spotify|discord|vesktop|brave-cinhimbnkkaeohfgghhklpknlkffjgod-Default)$" },
    workspace = "name:media",
})

hl.window_rule({
    name  = "space-apps",
    match = { class = "^(steam|heroic)$" },
    workspace = "name:space",
})

-- Column width rules in scrolling layout (scrolling_width = 0.8)
local wide_apps = {
    "google%-chrome", "spotify", "vesktop", "discord", "brave", "Code", "code", "zed", "antigravity",
    "zen", "emacs", "AppCenter", "kdenlive", "waywallen", "steam_app_431960",
    "agimnkijcaahngcdmfeangaknmldooml", "cinhimbnkkaeohfgghhklpknlkffjgod", "libreoffice", "gimp", "krita", "inkscape"
}
for _, app in ipairs(wide_apps) do
    hl.window_rule({
        name  = "wide-" .. app,
        match = { class = app },
        scrolling_width = 0.8,
    })
end

-- Layer Rules (Rofi and Vicinae)
hl.layer_rule({
    name  = "rofi-effects",
    match = { namespace = "rofi" },
    blur  = true,
    xray  = false,
})

hl.layer_rule({
    name  = "vicinae-blur",
    match = { namespace = "vicinae" },
    blur  = true,
    ignore_alpha = 0,
})
