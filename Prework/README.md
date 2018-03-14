Prerequisites
-------------

We are assuming that you have some familiarity with R before attending
this hands-on seminar. Please review our [R/RStudio
Intro](https://github.com/ravichas/TidyingData/blob/master/0-RStudio-Intro.md)
before coming, and if you are unfamiliar with the material covered there
or if you would like to brush up on your basic R skills before
attending, you may find the
[DataCamp](https://www.datacamp.com/courses/free-introduction-to-r) or
[TryR](http://tryr.codeschool.com) tutorials helpful. Both of these
tutorials pretty much cover the same material.

There is also a nice tutorial within the `swirl` package. To start this
up, run the following commands within RStudio:

    install.packages("swirl")
    library(swirl)
    swirl()

Computer setup
--------------

Computers in the training room will have R, RStudio, and the packages
we'll be using installed, but if you would like to bring your own
computer, please install the following:

-   [R](https://cran.r-project.org)
-   [RStudio](https://www.rstudio.com/products/rstudio/download/)
-   The [tidyverse](https://www.tidyverse.org/) package (you can install
    these using the code below):

To check for the required packages and to install any missing packages,
you can run this code within the RStudio console window:

    if(!require(tidyverse))
        install.packages('tidyverse')

To verify that you have correctly set up your system, run this line of
code in RStudio. It will either print a message to your screen
indicating your computer is setup properly, or it will throw an error
with information on missing packages.

    source('https://raw.githubusercontent.com/ravichas/TidyingData/master/Prework/systemCheck.R')

    ## Loading required package: broom

    ## [1] "Your machine is ready for the Data Tidying seminar."
