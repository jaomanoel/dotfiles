return {
	{
		"mfussenegger/nvim-jdtls",
		ft = { "java" },
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

			local config = {
				-- The command that starts the language server
				-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
				cmd = {

					-- 💀
					"java", -- or '/path/to/java17_or_newer/bin/java'
					-- depends on if `java` is in your $PATH env variable and if it points to the right version.

					-- Lombok
					"-javaagent:/home/jaomanoel/.local/share/nvim/mason/share/jdtls/lombok.jar",
					"-classpath",
					"/home/jaomanoel/.local/share/nvim/mason/packages/jdtls/lombok.jar",

					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xmx1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",

					-- 💀
					"-jar",
					vim.fn.expand(
						"/home/jaomanoel/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar"
					),
					-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
					-- Must point to the                                                     Change this to
					-- eclipse.jdt.ls installation                                           the actual version

					-- 💀
					"-configuration",
					vim.fn.expand("/home/jaomanoel/.local/share/nvim/mason/packages/jdtls/config_linux"),
					-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
					-- Must point to the                      Change to one of `linux`, `win` or `mac`
					-- eclipse.jdt.ls installation            Depending on your system.

					-- 💀
					-- See `data directory configuration` section in the README
					"-data",
					vim.fn.expand("/home/jaomanoel/.cache/jdtls/workspace/") .. project_name,
				},

				-- 💀
				-- This is the default if not provided, you can remove it. Or adjust as needed.
				-- One dedicated LSP server & client will be started per unique root_dir
				root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),

				-- Here you can configure eclipse.jdt.ls specific settings
				-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
				-- for a list of options
				settings = {
					java = {
						completion = {
							favoriteStaticMembers = {
								"org.hamcrest.MatcherAssert.assertThat",
								"org.hamcrest.Matchers.*",
								"org.hamcrest.CoreMatchers.*",
								"org.junit.jupiter.api.Assertions.*",
								"java.util.Objects.requireNonNull",
								"java.util.Objects.requireNonNullElse",
								"org.mockito.Mockito.*",
							},
							importOrder = {
								"java",
								"javax",
								"com",
								"org",
							},
						},
						filteredTypes = {
							"com.sun.*",
							"io.micrometer.shaded.*",
							"java.awt.*",
							"jdk.*",
							"sun.*",
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
						codeGeneration = {
							toString = {
								template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
							},
							constructor = {
								params = "${members.collect { it.name() + ' ' + it.type() }.join(', ')}",
								body = "${members.collect { 'this.' + it.name() + ' = ' + it.name() }.join('; ')}",
								template = "public ${object.className}(${params}) {${body}}",
							},
							hashCodeEquals = {
								useJava7Objects = true,
							},
							useBlocks = true,
							addFinalForNewDeclaration = "fields",
						},
						configuration = {
							lombok = {
								enabled = true,
							},
							runtimes = {
								{
									name = "JavaSE-21",
									path = "/usr/lib/jvm/java-21-openjdk",
								},
								{
									name = "JavaSE-17",
									path = "/usr/lib/jvm/java-17-openjdk",
								},
							},
							maven = {
								downloadSources = true,
							},
							referencesCodeLens = {
								enabled = true,
							},
							references = {
								includeDecompiledSources = true,
							},
							inlayHints = {
								parameterNames = {
									enabled = "all", -- literals, all, none
								},
							},
							format = {
								enabled = false,
								tabSize = 2,
							},
						},
						signatureHelp = { enabled = true },
					},
				},

				-- Language server `initializationOptions`
				-- You need to extend the `bundles` with paths to jar files
				-- if you want to use additional eclipse.jdt.ls plugins.
				--
				-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
				--
				-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
				init_options = {
					bundles = {},
				},
				capabilities = capabilities,
			}
			-- This starts a new client & server,
			-- or attaches to an existing client & server depending on the `root_dir`.
			require("jdtls").start_or_attach(config)
		end,
	},
}
