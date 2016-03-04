# Makefile for running OCR on PDFs

A common problem is to have a collection of PDFs for which one wishes to get plain text files with OCR text. This [Makefile](https://www.gnu.org/software/make/) offers a simple recipe for doing just that. It bursts each PDF into separate files for each page (with [pdftk](https://www.pdflabs.com/tools/pdftk-server/)), creates a PNG for each page (with [imagemagick](http://www.imagemagick.org/)), then runs [tesseract](https://github.com/tesseract-ocr/tesseract) OCR on each page, producing a single text file corresponding to the input PDF file, as well as OCR files for each page in the PDF.

This process can be slow for any individual PDF. However, it is very memory efficient and GNU Make provides parallelization for free, and it requires no point and click nonsense, so when running this on a batch of PDF files it can be quite efficient. And it is portable, so for very big batches I have thrown this up on an Digital Ocean droplet or Amazon EC2 instance and just let it run.

## Install dependencies

On a Mac with [Homebrew](http://brew.sh/):

```
brew install imagemagick
brew install tesseract
```

Getting PDFtk on a recent version of Mac OS X is a bit more tricky. Hopefully [PDFtk server](https://www.pdflabs.com/tools/pdftk-server/) will be updated on the main website and in Homebrew soon. In the meantime, install the [version in this Stack Overflow thread](http://stackoverflow.com/questions/32505951/pdftk-server-on-os-x-10-11) if you are using El Capitan.

On Ubuntu 14.04:

```
sudo apt-get install pdftk
sudo apt-get install imagemagick
sudo apt-get install tesseract-ocr 
```

## Use

Put all the PDFs that you want OCRed in the same directory as this Makefile. Run `make`. If you want run the recipe in parallel, run `make -j 4` where the number is how many processes you want to run at once. To get rid of the intermediate products, run `make clean`; the get rid of the OCR text and start over, run `make clobber`. Your OCR text files will be in the directory `ocr/`, and the OCR text files for each page will be in `ocr-pages/`.

You can control various options for tesseract by editing the `tesseract-config` file. And you can control the DPI at which the OCR is run and the language by editing a variable at the top of the `Makefile.`

## License

Copyright 2016 [Lincoln Mullen](http://lincolnmullen.com). [Licensed MIT](https://opensource.org/licenses/MIT).

