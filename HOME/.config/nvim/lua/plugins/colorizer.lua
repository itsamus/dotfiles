require'colorizer'.setup({
    '*', -- Kleurt alle bestanden
    css = { rgb_fn = true; }, -- Activeer rgb() functies voor CSS
}, {
    RGB      = true;          -- #RGB hex codes
    RRGGBB   = true;          -- #RRGGBB hex codes
    names    = true;          -- "Name" kleuren zoals Blue of Aqua
    RRGGBBAA = true;          -- #RRGGBBAA hex codes
    AARRGGBB = true;          -- 0xAARRGGBB hex codes
    rgb_fn   = true;          -- CSS rgb() en rgba() functies
    hsl_fn   = true;          -- CSS hsl() en hsla() functies
    css      = true;          -- Beheer alle CSS kleurfuncties
    css_fn   = true;          -- Beheer al de CSS kleurfuncties
    mode     = 'background';  -- Opties: 'background', 'foreground', 'virtualtext'
})
	--
	-- RGB      = true;         -- #RGB hex codes
	-- RRGGBB   = true;         -- #RRGGBB hex codes
	-- names    = true;         -- "Name" codes like Blue
	-- RRGGBBAA = true;        -- #RRGGBBAA hex codes
	-- rgb_fn   = true;        -- CSS rgb() and rgba() functions
	-- hsl_fn   = true;        -- CSS hsl() and hsla() functions
	-- css      = true;        -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	-- css_fn   = true;        -- Enable all CSS *functions*: rgb_fn, hsl_fn
	-- -- Available modes: foreground, background
	-- mode     = 'background'; -- Set the display mode.
	--  }
	--
	--
