Config = {}

Config = {
    SingleLineText = "Hud F7 | F5 Buttons", -- Change to what you want displayed on the hud.
    UpdateInterval = 60000, -- How often to update the hud. (milliseconds), Hud elements will still update instantly no matter what you set this too. (Not Worth Touching).
    FpsUpdateInterval = 4000, -- How often to update the Fps counter  (milliseconds), 4 seconds is recommended. 
    HudKey = 'F7', -- The keybind to toggle the hud Colour Pallet on and off.
    
    ColorPresets = { -- Colour presets for the hud, you can add more if you want.
        { 
            name = "Blue",                               -- Name shown in color picker menu.
            background = "rgba(0, 200, 255, 0.377)",     -- Semi-transparent blue background (37.7% opacity).
            border = "#00c8ff80",                        -- Blue border with 50% transparency (80 hex = 50% opacity).
            shadow = "rgba(0, 200, 255, 0.3)"            -- Blue glow/shadow effect at 30% opacity.
        },
        {
            name = "Red",
            background = "rgba(255, 0, 0, 0.377)",
            border = "#ff000080",
            shadow = "rgba(255, 0, 0, 0.3)"
        },
        {
            name = "Green",
            background = "rgba(0, 255, 0, 0.377)",
            border = "#00ff0080",
            shadow = "rgba(0, 255, 0, 0.3)"
        },
        {
            name = "Purple",
            background = "rgba(147, 0, 255, 0.377)",
            border = "#9300ff80",
            shadow = "rgba(147, 0, 255, 0.3)"
        },
        {
            name = "Gold",
            background = "rgba(255, 215, 0, 0.377)",
            border = "#ffd70080",
            shadow = "rgba(255, 215, 0, 0.3)"
        },
        {
            name = "Pink",
            background = "rgba(255, 20, 147, 0.377)",
            border = "#ff149380",
            shadow = "rgba(255, 20, 147, 0.3)"
        },
        {
            name = "Cyan",
            background = "rgba(0, 255, 255, 0.377)",
            border = "#00ffff80",
            shadow = "rgba(0, 255, 255, 0.3)"
        },
        {
            name = "Orange",
            background = "rgba(255, 140, 0, 0.377)",
            border = "#ff8c0080",
            shadow = "rgba(255, 140, 0, 0.3)"
        },
        {
            name = "Lime",
            background = "rgba(50, 205, 50, 0.377)",
            border = "#32cd3280",
            shadow = "rgba(50, 205, 50, 0.3)"
        },
        {
            name = "Magenta",
            background = "rgba(255, 0, 255, 0.377)",
            border = "#ff00ff80",
            shadow = "rgba(255, 0, 255, 0.3)"
        },
        {
            name = "Turquoise",
            background = "rgba(64, 224, 208, 0.377)",
            border = "#40e0d080",
            shadow = "rgba(64, 224, 208, 0.3)"
        },
        {
            name = "Crimson",
            background = "rgba(220, 20, 60, 0.377)",
            border = "#dc143c80",
            shadow = "rgba(220, 20, 60, 0.3)"
        },
        {
            name = "Indigo",
            background = "rgba(75, 0, 130, 0.377)",
            border = "#4b008280",
            shadow = "rgba(75, 0, 130, 0.3)"
        },
        {
            name = "Teal",
            background = "rgba(0, 128, 128, 0.377)",
            border = "#00808080",
            shadow = "rgba(0, 128, 128, 0.3)"
        },
        {
            name = "Violet",
            background = "rgba(238, 130, 238, 0.377)",
            border = "#ee82ee80",
            shadow = "rgba(238, 130, 238, 0.3)"
        },
        {
            name = "Coral",
            background = "rgba(255, 127, 80, 0.377)",
            border = "#ff7f5080",
            shadow = "rgba(255, 127, 80, 0.3)"
        },
        {
            name = "Aquamarine",
            background = "rgba(127, 255, 212, 0.377)",
            border = "#7fffd480",
            shadow = "rgba(127, 255, 212, 0.3)"
        },
        {
            name = "HotPink",
            background = "rgba(255, 105, 180, 0.377)",
            border = "#ff69b480",
            shadow = "rgba(255, 105, 180, 0.3)"
        },
        {
            name = "RoyalBlue",
            background = "rgba(65, 105, 225, 0.377)",
            border = "#4169e180",
            shadow = "rgba(65, 105, 225, 0.3)"
        },
        {
            name = "Emerald",
            background = "rgba(46, 204, 113, 0.377)",
            border = "#2ecc7180",
            shadow = "rgba(46, 204, 113, 0.3)"
        }
    }
}
