help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

test: ## Run tests
	@nvim --headless --noplugin -u ./tests/init.lua -c "lua MiniTest.run()"

clean: ## Delete .tests/ (test config for Neovim instance)
	@rm -fr .tests
