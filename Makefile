OCR_OUTPUTS := $(patsubst %.pdf, text/%.txt, $(wildcard *.pdf))
PNG_DPI := 600
LANGUAGE := eng

all : $(OCR_OUTPUTS) 

text/%.txt : %.pdf
	@mkdir -p temp
	@mkdir -p text
	@echo "$^: bursting into a PDF for each page ..."
	@pdftk $^ burst output temp/$*.page-%08d.pdf
	@echo "$^: converting pages into images ..."
	@for pdf in temp/$*.page-*.pdf ; do \
		convert -density $(PNG_DPI) -depth 8 $$pdf $$pdf.png ; \
	done
	@echo "$^: running OCR on each page ..."
	@for png in temp/$*.page-*.png ; do \
		tesseract $$png $$png tesseract-config -l $(LANGUAGE) > /dev/null 2>&1; \
	done
	@cat temp/$*.page-*.png.txt > text/$*.txt
	@echo "$^: Finished running OCR."

.PHONY : clean
clean :
	rm -rf temp/*

.PHONY : clobber
clobber : clean 
	rm -rf text/*
