-- Create button for initial keybind.
--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position       = "center",
        shortcut       = sc,
        cursor         = 5,
        width          = 50,
        align_shortcut = "right",
        hl_shortcut    = "Conditional",
    }
    if keybind then
        keybind_opts = vim.F.if_nil(keybind_opts, {noremap = true, silent = true, nowait = true})
        opts.keymap = {"n", sc_, keybind, keybind_opts}
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(sc_ .. '<Ignore>', true, false, true)
        vim.api.nvim_feedkeys(key, "normal", false)
    end

    return {
        type     = "button",
        val      = txt,
        on_press = on_press,
        opts     = opts,
    }
end
local buttons = {
    type = "group",
    val = {
        button("e", "  New Buffer",            ':tabnew<CR>'),
        button("f", "  Find file",             ':Telescope find_files<CR>'),
        button("h", "  Recently opened files", ':Telescope oldfiles<CR>'),
        button("r", "  Frecency/MRU",          ':Telescope oldfiles<CR>'),
        button("g", "  Open Last Session",     ':source ~/.config/nvim/session.vim<CR>'),
        button("m", "  Word Finder",           ':Telescope live_grep<CR>'),
        button("l", "  Marks",                 ':Telescope marks<CR>'),
    },
    opts = {
        spacing = 1
    }
}

local function rainbow_cow()

    local cowfiles ={ "beavis.zen", "blowfish", "bong", "bud-frogs", "bunny", "cheese", "cower", "daemon", "default", "dragon",
    "dragon-and-cow", "elephant", "elephant-in-snake", "eyes", "flaming-sheep", "ghostbusters",
    "head-in", "hellokitty", "kiss", "kitty", "koala", "kosh", "luke-koala", "meow", "milk", "moofasa", "moose",
    "mutilated", "ren", "satanic", "sheep", "skeleton", "small", "stegosaurus", "stimpy", "supermilker",
    "surgery", "three-eyes", "turkey", "turtle", "tux", "udder", "vader", "vader-koala", "www"}

    local cowfile = cowfiles[math.random(#cowfiles)]
    return  "fortune -s  | cowthink -f " .. cowfile .. "| lolcat -t"
end

local function matrix(message)
    if message == nil or message == "" then

        return "cmatrix -u 10 -M 'Coffee?'"
    end

    return "cmatrix -u 10 -M" .. message 
end

local term_height = 15
local config = {
    layout = {
        { type = "padding", val = term_height + 5 },
        {
            type = "terminal",
            command = matrix(), --
            width = 50,
            height = term_height,
            opts = {
                redraw = true,
                window_config = {border={"*"}, anchor="NW" }
            },
        },
        --{ type = "padding", val = 5 },
        buttons,
    },
    opts = {
        noautocmd = false,
    },
}

local alpha = require("alpha")
require("alpha.term")

alpha.setup(config)
