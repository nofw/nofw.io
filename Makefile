# A Self-Documenting Makefile: http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

.PHONY: update-theme
.DEFAULT_GOAL := help

update-theme: ## Update the site theme
	rm -rf themes/mater && mkdir -p themes/mater
	curl -L https://github.com/sagikazarmark/mater/archive/master.tar.gz | tar xz --strip-components=1 -C themes/mater

help:
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
