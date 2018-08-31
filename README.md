# Notes for revisions: 

- The *xlsx* package is quite heavily java reliant, so setup can be annoying depending on admin rights/java home directories and it can also be quite slow/fail with larger datasets 
  - Alternative options include tidyverse's *readxl* package (issue: creates a tbl rather than a dataframe with complicated POSIxct dates; could just add an extra step where change from tbl to data frame), or the *RODBC* package which can connect to many different sources (issue: unecessary extra code). Many other java based excel connection packages exist but dont really differ from *xlsx*. 
- The *Hmisc* package is only used for the describe function, not sure we actually need to include it in the case study, could mention that it is out there but think that str and summary give enough information. The issue is *Hmisc* sometimes creates problems on install depending on admin rights and read/write folders etc. 
- Unsure about how much explanation of code is needed; the stata case study has almost none, but code is quite similar. If this is not the first case study used then perhaps the level of explanation is not necessary. 
- Perhaps use ggplot for figures?? Base uses heavy code to create nice plots and otherwise ends up quite ugly...





# Analysis of surveillance data: Analysing Cryptosporidium notification data from country X, 2004-2015

This is the repository for the Epiconcept Cryptosporidium case study using *R* statistical programming software. 

The following files are included: 

- *EpiconceptCryptoCaseStudy.Rmd*: an R-markdown file which has all the text and analysis script for the case study. This uses the "worded" package for styling word documents (mostly for being able to insert page breaks) - which can be installed using devtools::install_github("davidgohel/worded"). The package is loaded at the of the markdown script within the r setup code-chunk.
  - In order for this to work you will require [Pandoc](https://pandoc.org/installing.html) and also a LaTeX processor such as [MiKTeX](https://miktex.org/download). 
- *README.md*: a markdown file that is used to create this introductory text for the git-hub repository. 
- *EpiconceptCrypto.Rproj*: an R project required for being able to push scripts up on to git-hub. 
- *.gitignore*: required for the initiation of git repositories. 
