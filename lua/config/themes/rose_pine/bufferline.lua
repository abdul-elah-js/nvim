local p = require("rose-pine.palette")
local utils = require("lua.config.utils")
return {
	colorscheme_overrides = utils.merge({
		warning_diagnostic_selected = {
			bg = p.surface,
		},
		info_diagnostic_selected = {
			bg = p.surface,
		},
		error_diagnostic_selected = {
			bg = p.surface,
		},
		hint_diagnostic_selected = {
			bg = p.surface,
		},
		hint_selected = {
			bg = p.surface,
		},
		info_selected = {
			bg = p.surface,
		},
		error_selected = {
			bg = p.surface,
		},
		warning_selected = {
			bg = p.surface,
		},
		numbers_selected = {
			bg = p.surface,
		},
		modified_selected = {
			fg = "#ffffff",
			bg = p.surface,
		},
		buffer_selected = {
			bg = p.surface,
			bold = true,
			italic = true,
		},
		duplicate_selected = {
			bg = p.surface,
			bold = true,
			italic = true,
		},
		separator_selected = {
			bg = p.surface,
			bold = true,
			italic = true,
		},
		close_button_selected = {
			bg = p.surface,
			bold = true,
			italic = true,
		},
		indicator_selected = {
			bg = p.surface,
			bold = true,
			italic = true,
		},
		pick_selected = {
			bg = p.surface,
			bold = true,
			italic = true,
		},
	}),
}
