local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

local function generate_constructor(args, parent)
	local buf = vim.api.nvim_get_current_buf()
	local parser = vim.treesitter.get_parser(buf, "java")
	if not parser then
		return "Erro: Parser Tree-sitter para Java não encontrado."
	end

	local tree = parser:parse()[1]
	local root = tree:root()

	-- Procurar campos da classe (type: "field_declaration")
	local fields = {}
	for node in root:iter_children() do
		if node:type() == "class_body" then
			for child in node:iter_children() do
				if child:type() == "field_declaration" then
					local type_node = child:child(0) -- Tipo do campo
					local declarator_node = child:child(1) -- Nome do campo

					local field_type = vim.treesitter.get_node_text(type_node, buf)
					local field_name = vim.treesitter.get_node_text(declarator_node, buf)

					if field_type and field_name then
						table.insert(fields, { name = field_name, type = field_type })
					end
				end
			end
		end
	end

	if #fields == 0 then
		return "Nenhum campo encontrado na classe."
	end

	-- Gerar construtor
	local class_name = vim.fn.expand("%:t:r") -- Nome da classe baseado no nome do arquivo
	local args = {}
	local body = {}

	for _, field in ipairs(fields) do
		table.insert(args, string.format("%s %s", field.type, field.name))
		table.insert(body, string.format("        this.%s = %s;", field.name, field.name))
	end

	return string.format(
		[[
    public %s(%s) {
%s
    }
    ]],
		class_name,
		table.concat(args, ", "),
		table.concat(body, "\n")
	)
end

-- Registrar snippet
ls.add_snippets("java", {
	s("ctors", f(generate_constructor, {})),
})
