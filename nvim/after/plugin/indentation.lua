require("ibl").setup {
	scope = {
		exclude = {
			node_type = {
				["*"] = { "if_statement", "comment", "function_definition", "variable_declaration", "preprocessor" }
			}
		}
	}
}

