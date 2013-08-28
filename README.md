README
=====

This project is a conversion of the 'The Tachypomp and Other Stories' into a nanoc application. It serves as a
"proof of concept" to demonstrate publishing an ebook in a variety of formats using nanoc. The project currently 
generates content in both ePub, hPub and HTML (for online viewing) formats.   

NB: The original text was sourced from the Gutenberg Project. The source file has been resaved in UTF-8 format to remove invalid multibyte char (UTF-8), as the source file from the Gutenberg Project came with Latin-1 encoding.

This project is still very much a work in progress. The long-term goal is to develop a general-purpose framework for
building content in a variety of formats.

Installation
---

Clone the project into your local filesystem: 

```
git clone git@github.com:ferrisoxide/tachypomp.git
cd tachypomp
cp nanoc.yaml.example nanoc.yaml
bundle install
```

The project assumes Ruby 1.9.3 is installed and will use RVM if available.

Importing Content
---

The sample text "The Tachypomp and Other Stories" is a collection of short stories, written by Edward Page Mitchells. The source is maintained in a single text file to simplify editing. This is my preferred way of working with creative writing, but it's not the only way to publish via nanoc. You could just as easily maintain all your writing in a set of pages in the _/content_. I've done this in the past, but found it harder to edit or keep a track of where I was up to. 

To import the source text, run the following from within the project's root folder:

`nanoc import`

NB: The path to the source file is specified in the `ebook.yaml` file.

This will generate content files by breaking the larger file into several smaller ones, using the `breakdown` gem. It will also create an `book.json` file in the _/content folder_. The `book.json` file is loosely based on the hPub ebook specification, and is used by other processes to build table of contents for alternative formats.

Compiling Content
---

The imported content will need to be compiled using nanoc: 

`nanoc compile`

Once the content is compiled it can be packaged into different formats. Currently only ePub 2 and hPub formats are supported. To package the ebook run the following:

`nanoc build`

This will build ePub and hPub compatible files in _/output/epub/book_ and _/output/hpub_ respectively.

TO DO
---

* Clean up the code (was a bit of a hack)
* Add support for PDF (maybe)
* Stylesheets for ePub and hPub versions

