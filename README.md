# Notes for revisions: 

None

# Errors in the STATA do-files 
- There is an error in the data cleaning do-file (cant remember exactly, think it was imported) 
- There is an error in line 26 of Annual incidence rates (should be a "means" in "ci" - same for all following occurences)
- The forloop of annual incidence rates correcting to 100,000 pop also doesnt work 
- Saving "crypto inc by year.dta" is done in the "annual incidence rates" do-file, but not in the original case study word document



# Analysis of surveillance data: Analysing Cryptosporidium notification data from country X, 2004-2015

This is the repository for the Epiconcept Cryptosporidium case study using *R* statistical programming software. 

The following files are included: 

- *EpiconceptCryptoCaseStudy.Rmd*: an R-markdown file which has all the text and analysis script for the case study. This uses the "worded" package for styling word documents (mostly for being able to insert page breaks) - which can be installed using devtools::install_github("davidgohel/worded"). The package is loaded at the of the markdown script within the r setup code-chunk.
  - In order for this to work you will require [Pandoc](https://pandoc.org/installing.html) and also a LaTeX processor such as [MiKTeX](https://miktex.org/download). 
- *README.md*: a markdown file that is used to create this introductory text for the git-hub repository. 
- *EpiconceptCrypto.Rproj*: an R project required for being able to push scripts up on to git-hub. 
- *.gitignore*: required for the initiation of git repositories. 
- *crypto.csv*, *region.csv*, *agegroup.csv*, *agegroupregion.csv*: CSV versions of the original datafiles for the case study. 
- *EpiconceptCryptoCaseStudy.docx*: Word document output of the *EpiconceptCryptoCaseStudy.Rmd* for the case study
