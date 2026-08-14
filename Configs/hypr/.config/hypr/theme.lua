-- Handles color parsing and look & feel settings
local M = {}

function M.parse_colors()
    local colors = {}
    local home = os.getenv("HOME")
    local paths_to_try = {
        home .. "/.config/hypr/colors.conf",
        home .. "/.config/hypr/themes/matugen.conf",
        home .. "/.config/hypr/themes/gruvbox-dark.conf"
    }

    local function read_conf(path)
        local f = io.open(path, "r")
        if not f then return end
        for line in f:lines() do
            local clean_line = line:gsub("//.*", ""):gsub("#.*", ""):gsub("^%s*(.-)%s*$", "%1")
            if clean_line ~= "" then
                local src = clean_line:match("^source%s*=?%s*(.+)$")
                if src then
                    src = src:gsub("^~", home)
                    if not src:match("^/") then
                        src = home .. "/.config/hypr/" .. src
                    end
                    read_conf(src)
                else
                    local name, val = clean_line:match("^%s*%$(%w+)%s*=%s*(.+)%s*$")
                    if name and val then
                        val = val:gsub("^%s*(.-)%s*$", "%1")
                        colors[name] = val
                    end
                end
            end
        end
        f:close()
    end

    read_conf(paths_to_try[1])

    local resolved = {}
    for k, v in pairs(colors) do
        local val = v
        for var in v:gmatch("%$(%w+)") do
            if colors[var] then
                val = val:gsub("%$" .. var, colors[var])
            end
        end
        resolved[k] = val
    end
    return resolved
end

local colors = M.parse_colors()

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 5,
        border_size = 1,
        col = {
            active_border   = "rgba(555555ff)",
            inactive_border = "rgba(222222ff)",
        },
        resize_on_border = true,
        allow_tearing = false,
        no_focus_fallback = true, -- Disable window focus looping around layout edges
        layout = "scrolling",
    },

    decoration = {
        rounding       = 16,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 0.85,

        shadow = {
            enabled      = true,
            range        = 6,
            render_power = 2,
            color        = 0x44000000, -- Subtle soft shadow
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 3,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
        workspace_wraparound = false, -- Disable workspace animation wraparound
    },
})

-- Sizing & presets for scrolling layout (matching Niri behavior)
hl.config({
    scrolling = {
        fullscreen_on_one_column = false, -- Keep single window at default 50% width instead of stretching 100%
        column_width = 0.5,               -- Default column width (50%)
        explicit_column_widths = "0.33333, 0.5, 0.8", -- Preset column widths matching Niri
        focus_fit_method = 0,             -- 0 = Center active column (matching Niri always-center-single-column)
        follow_focus = true,
        direction = "right",
        wrap_focus = false,               -- Disable wrapping at tape ends
        wrap_swapcol = false,
    },
})

-- Curves and animations
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Fast, non-bouncy spring physics (stiffness = 650 for speed, dampening = 52 for zero-bounce critical damping)
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 650, dampening = 52 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })

-- Niri-style Vertical Workspace Transitions (slidevert)
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 2.5,  bezier = "easeOutQuint", style = "slidevert" })

return M
