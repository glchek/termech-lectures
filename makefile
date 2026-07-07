DOC = main

.PHONY: all clean FORCE $(DOC).pdf

all: $(DOC).pdf

git-commit.tex: FORCE
	@HASH=$$(git rev-parse --short HEAD 2>/dev/null || echo "unknown"); \
	printf '\\newcommand{\\gitcommit}{%s}\n' "$$HASH" > git-commit.tmp; \
	if ! cmp -s git-commit.tmp git-commit.tex; then \
		mv git-commit.tmp git-commit.tex; \
	else \
		rm -f git-commit.tmp; \
	fi

$(DOC).pdf: git-commit.tex
	latexmk -pdf -use-make $(DOC).tex

clean:
	latexmk -C
	rm -f git-commit.tex