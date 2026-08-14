hl.config({
    input = {
        kb_layout  = "us",
        numlock_by_default = true,
        follow_mouse = 0, -- Disable focus on mouse hover (click to focus)
        sensitivity = 0.0,

        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
        },
    },

    cursor = {
        no_warps = true,
        warp_on_change_workspace = 0,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})
