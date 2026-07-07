DOC = main

LATEX = pdflatex

.PHONY: all clean FORCE

all: $(DOC).pdf

git-commit.tex: FORCE
	@HASH=$$(git rev-parse --short HEAD 2>/dev/null || echo "unknown"); \
	printf '\\newcommand{\\gitcommit}{%s}\n' "$$HASH" > git-commit.tmp; \
	if ! cmp -s git-commit.tmp git-commit.tex; then \
		mv git-commit.tmp git-commit.tex; \
	else \
		rm -f git-commit.tmp; \
	fi

$(DOC).pdf: $(DOC).tex git-commit.tex
	$(LATEX) $(DOC).tex
	$(LATEX) $(DOC).tex

clean:
	rm -f $(DOC).pdf $(DOC).aux $(DOC).log $(DOC).toc $(DOC).out git-commit.tex