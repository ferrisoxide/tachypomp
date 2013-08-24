README
=====

This project is a conversion of the 'The Tachypomp and Other Stories' into a nanoc application. It serves as a
"proof of concept" to demonstrate publishing an ebook in a variety of formats using nanoc. The project currently 
generates content in both ePub and HTML (for online viewing) formats.   

NB: The original text was sourced from the Gutenberg Project. The source file has been resaved in UTF-8 format to remove invalid multibyte char (UTF-8), as the source file from the Gutenberg Project came with Latin-1 encoding.

HOW TO USE
======

Clone the project into your local filesystem. The project assumes Ruby 2.0 is installed and will use RVM if available. The usual `bundle install` process applies.

The sample text "The Tachypomp and Other Stories" is a collection of short stories, written by Edward Page Mitchells. The source is maintained in a single text file to simplify editing. This is my preferred way of working with creative writing, but it's not the only way to publish via nanoc. You could just as easily maintain all your writing in a set of pages in the _/content_. I've done this in the past, but found it harder to edit or keep a track of where I was up to. 

To import the source text, run the following from within the project's root folder:

`nanoc import --filename the-tachypomp-and-other-stories.md`

This will generate content files by breaking the larger file into several smaller ones, using the `breakdown` gem. It will also create an `ebook.json` file in the /content folder. The `ebook.json` file is loosely based on the hPub ebook specification, and is used by other processes to build table of contents for alternative formats.

The imported content will need to be compiled using the 

`nanoc compile`

Once the content is compiled it can be packaged into different formats. Currently on ePub 2 format is supported (though hPub should be available shortly). To package an ePub book run the following:

`nanoc build_epub`

This will build an ePub compatible file in _/output/epub/book_.

TO DO
===

* Clean up the code (was a bit of a hack)
* Add support for hPub
* Add support for PDF (maybe)
* Simplify the configuration
* Improve the 'guard' watch for the source text file

