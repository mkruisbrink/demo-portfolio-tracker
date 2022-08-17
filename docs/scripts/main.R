
# set wd in order for task scheduler to read script as a stand-alone file without the .Rproj working environment
#setwd("D:/Max Kruisbrink/Developer/R-projects/demo-portfolio-tracker")

#declare root
here::i_am("scripts/main.R")

#read project specific .Renviron variables
readRenviron(".Renviron")

#using library(here) to source all components
library(here)

#libraries 
source(here("scripts/libraries.R"))


#construct portfolio, merge with latest ticker data and write to .csv
source(here("scripts/create-portfolio.R"))

#render flexdashboard
#library(rmarkdown)
rmarkdown::render("index.Rmd")
