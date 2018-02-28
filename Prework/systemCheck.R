# check that your system is set up for the Data Tidying hands-on seminar

if(!require(tidyverse))
    error("The tidyverse package is not installed properly.")

if(!require(biobroom))
    error("The biobroom package is not installed properly.")

print("Your machine is ready for the Data Tidying seminar.")