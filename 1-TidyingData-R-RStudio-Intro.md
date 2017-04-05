BTEP-R/RStudio-Intro
================
Drs. Sarangan Ravichandran and Randall Johnson
February 26, 2017

### Cleaning up

Before we begin, let us clean up the environment and set a working directory. This will clear all the variables and start fresh. If you want to follow on, then we suggest you to run the following lines.

``` r
setwd("H:/2017/BTEP1-TidyingData")
rm(list = ls())
```

### Loading the libraries

Let us first load the libraries needed for the workshop

``` r
# if you dont have tidyverse then run the following line once 
# install.packages(c("tidyverse", "knitr"))
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(knitr)
library(lubridate)
```

    ## 
    ## Attaching package: 'lubridate'

    ## The following object is masked from 'package:base':
    ## 
    ##     date

### Quick tour of RStudio

We will be using RStudio as the main software for the workshp. Let us do a quick live tour of RStudio. We will cover the following useful options accessible through RStudio:

#### Tools

-   Pane (View --&gt; Pane); Option that we are using is "Console on Right"
-   Tools --&gt; Install Packages
-   Tools --&gt; Global Options
-   Session --&gt; Set Working Directory
-   Optons --&gt; R Session
-   File --&gt; Import DataSet

![](Images/RStudioIntro.png)

### Getting the data in R via RStudio

Let us introduce R/R-Studio Data Import with a Import Dataset and Command-line options

![](Images/RS-ImportDataset.png)

The following few lines will explain how to read in a data file via R command-line

Please note that we will be using **readr** function for this section. Note that **read\_csv** is different than **read.csv**

-   read\_csv(), read\_csv2()
-   Note that read\_csv2 and read\_csv are same except for what options are default
-   The returning objects from read\_csv and read.csv are different (DF vs tibbles)
-   Other read functions, read\_tsv() and read\_delim()

Let us do some examples to compare <span style="color:blue">read.csv</span> and <span style="color:red">read\_csv</span> R functions
------------------------------------------------------------------------------------------------------------------------------------

Watch out how the column names are displayed and additional information that you get from <span style="color:red">read\_csv</span>. Also note that the number of rows are displayed in <span style="color:blue">read.csv</span> compared to <span style="color:red">read\_csv</span>

``` r
(tcsv <- read.csv("Data/WHO-2a.csv"))  # traditional csv object
```

    ##                             Country X2007.2013 X2007.2013.1
    ## 1                           Bahamas       15.9          2.2
    ## 2  Bolivia (Plurinational State of)        4.5          3.5
    ## 3                            Brazil       11.3           NA
    ## 4                      Burkina Faso        2.9          2.2
    ## 5                           Burundi        2.8          1.7
    ## 6                             China        1.4          1.6
    ## 7                          Colombia        3.1           NA
    ## 8                             Congo       11.5          6.5
    ## 9                      Cook Islands        4.5           NA
    ## 10 Democratic Republic of the Congo        2.3          2.0
    ## 11               Dominican Republic        9.4          1.2
    ## 12                          Ecuador        5.0           NA
    ## 13                      El Salvador       16.4           NA
    ## 14                            Haiti        7.3          4.8
    ## 15                            India       86.3         33.1
    ## 16                        Indonesia        2.0          1.8
    ## 17       Iran (Islamic Republic of)        1.3          1.3
    ## 18                       Kyrgyzstan        3.4           NA
    ## 19                           Malawi        3.9           NA
    ## 20                        Mauritius        5.9           NA
    ## 21                           Mexico        4.7           NA
    ## 22                        Nicaragua        5.7           NA
    ## 23                            Niger        3.9          2.9
    ## 24                             Oman        7.4           NA
    ## 25                             Peru        5.6          1.4
    ## 26                      Philippines       10.8         10.8
    ## 27              Republic of Moldova        4.7          5.2
    ## 28               Russian Federation        4.1          2.7
    ## 29                           Rwanda        3.6          1.7
    ## 30            Sao Tome and Principe       13.8          2.4
    ## 31                          Ukraine        3.7          4.0
    ## 32                           Zambia        4.7           NA

``` r
(ncsv <- read_csv("Data/WHO-2a.csv"))  # new csv, tibble object
```

    ## Warning: Duplicated column names deduplicated: '2007-2013' =>
    ## '2007-2013_1' [3]

    ## Parsed with column specification:
    ## cols(
    ##   Country = col_character(),
    ##   `2007-2013` = col_double(),
    ##   `2007-2013_1` = col_double()
    ## )

    ## # A tibble: 32 × 3
    ##                             Country `2007-2013` `2007-2013_1`
    ##                               <chr>       <dbl>         <dbl>
    ## 1                           Bahamas        15.9           2.2
    ## 2  Bolivia (Plurinational State of)         4.5           3.5
    ## 3                            Brazil        11.3            NA
    ## 4                      Burkina Faso         2.9           2.2
    ## 5                           Burundi         2.8           1.7
    ## 6                             China         1.4           1.6
    ## 7                          Colombia         3.1            NA
    ## 8                             Congo        11.5           6.5
    ## 9                      Cook Islands         4.5            NA
    ## 10 Democratic Republic of the Congo         2.3           2.0
    ## # ... with 22 more rows

See the difference in the returning objects' class. We will return to the data.frame and tbl\_df later.

``` r
class(ncsv) # traditional csv function, read.csv 
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

``` r
class(tcsv) # tidyverse read_csv
```

    ## [1] "data.frame"

How to read a dataset that has some metadata (indicated by \# ) as the first line followed by the column names?

``` r
read_csv("Data/WHO-2a.csv", comment = "#")
```

    ## Warning: Duplicated column names deduplicated: '2007-2013' =>
    ## '2007-2013_1' [3]

    ## Parsed with column specification:
    ## cols(
    ##   Country = col_character(),
    ##   `2007-2013` = col_double(),
    ##   `2007-2013_1` = col_double()
    ## )

    ## # A tibble: 32 × 3
    ##                             Country `2007-2013` `2007-2013_1`
    ##                               <chr>       <dbl>         <dbl>
    ## 1                           Bahamas        15.9           2.2
    ## 2  Bolivia (Plurinational State of)         4.5           3.5
    ## 3                            Brazil        11.3            NA
    ## 4                      Burkina Faso         2.9           2.2
    ## 5                           Burundi         2.8           1.7
    ## 6                             China         1.4           1.6
    ## 7                          Colombia         3.1            NA
    ## 8                             Congo        11.5           6.5
    ## 9                      Cook Islands         4.5            NA
    ## 10 Democratic Republic of the Congo         2.3           2.0
    ## # ... with 22 more rows

### Why do we insist on using readr::read\_csv than read.csv?

-   Speed (~ 10x)
-   Output from readr is Tibbles (we will expand on this later)
-   Base R taps into OS where it is executed. But readr functions are OS independent and hence reproducible

you can get and set a working directory by the following commands:

``` r
getwd()
setwd("YOUR_DIR"")
```

#### SessionInfo

Main development in R happens via packages. There are several hundred packages and the number is growing every day. Let us find out how many packages are there.

``` r
head(available.packages(repos = "http://cran.us.r-project.org"))
```

    ##             Package       Version Priority
    ## A3          "A3"          "1.0.0" NA      
    ## abbyyR      "abbyyR"      "0.5.0" NA      
    ## abc         "abc"         "2.1"   NA      
    ## ABCanalysis "ABCanalysis" "1.2.1" NA      
    ## abc.data    "abc.data"    "1.0"   NA      
    ## abcdeFBA    "abcdeFBA"    "0.4"   NA      
    ##             Depends                                              
    ## A3          "R (>= 2.15.0), xtable, pbapply"                     
    ## abbyyR      "R (>= 3.2.0)"                                       
    ## abc         "R (>= 2.10), abc.data, nnet, quantreg, MASS, locfit"
    ## ABCanalysis "R (>= 2.10)"                                        
    ## abc.data    "R (>= 2.10)"                                        
    ## abcdeFBA    "Rglpk,rgl,corrplot,lattice,R (>= 2.10)"             
    ##             Imports                            LinkingTo
    ## A3          NA                                 NA       
    ## abbyyR      "httr, XML, curl, readr, progress" NA       
    ## abc         NA                                 NA       
    ## ABCanalysis "plotrix"                          NA       
    ## abc.data    NA                                 NA       
    ## abcdeFBA    NA                                 NA       
    ##             Suggests                               Enhances
    ## A3          "randomForest, e1071"                  NA      
    ## abbyyR      "testthat, rmarkdown, knitr (>= 1.11)" NA      
    ## abc         NA                                     NA      
    ## ABCanalysis NA                                     NA      
    ## abc.data    NA                                     NA      
    ## abcdeFBA    "LIM,sybil"                            NA      
    ##             License              License_is_FOSS License_restricts_use
    ## A3          "GPL (>= 2)"         NA              NA                   
    ## abbyyR      "MIT + file LICENSE" NA              NA                   
    ## abc         "GPL (>= 3)"         NA              NA                   
    ## ABCanalysis "GPL-3"              NA              NA                   
    ## abc.data    "GPL (>= 3)"         NA              NA                   
    ## abcdeFBA    "GPL-2"              NA              NA                   
    ##             OS_type Archs MD5sum NeedsCompilation File
    ## A3          NA      NA    NA     "no"             NA  
    ## abbyyR      NA      NA    NA     "no"             NA  
    ## abc         NA      NA    NA     "no"             NA  
    ## ABCanalysis NA      NA    NA     "no"             NA  
    ## abc.data    NA      NA    NA     "no"             NA  
    ## abcdeFBA    NA      NA    NA     "no"             NA  
    ##             Repository                                
    ## A3          "http://cran.us.r-project.org/src/contrib"
    ## abbyyR      "http://cran.us.r-project.org/src/contrib"
    ## abc         "http://cran.us.r-project.org/src/contrib"
    ## ABCanalysis "http://cran.us.r-project.org/src/contrib"
    ## abc.data    "http://cran.us.r-project.org/src/contrib"
    ## abcdeFBA    "http://cran.us.r-project.org/src/contrib"

To get a detailed description of the attached packages and R session, use

``` r
sessionInfo()
```

    ## R version 3.3.2 (2016-10-31)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 7 x64 (build 7601) Service Pack 1
    ## 
    ## locale:
    ## [1] LC_COLLATE=English_United States.1252 
    ## [2] LC_CTYPE=English_United States.1252   
    ## [3] LC_MONETARY=English_United States.1252
    ## [4] LC_NUMERIC=C                          
    ## [5] LC_TIME=English_United States.1252    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] lubridate_1.6.0 knitr_1.15.1    dplyr_0.5.0     purrr_0.2.2    
    ## [5] readr_1.0.0     tidyr_0.6.1     tibble_1.2      ggplot2_2.2.1  
    ## [9] tidyverse_1.1.1
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.8      plyr_1.8.4       forcats_0.2.0    tools_3.3.2     
    ##  [5] digest_0.6.11    jsonlite_1.2     evaluate_0.10    nlme_3.1-128    
    ##  [9] gtable_0.2.0     lattice_0.20-34  psych_1.6.12     DBI_0.5-1       
    ## [13] yaml_2.1.14      parallel_3.3.2   haven_1.0.0      xml2_1.1.0      
    ## [17] stringr_1.1.0    httr_1.2.1       hms_0.3          rprojroot_1.2   
    ## [21] grid_3.3.2       R6_2.2.0         readxl_0.1.1     foreign_0.8-67  
    ## [25] rmarkdown_1.3    modelr_0.1.0     reshape2_1.4.2   magrittr_1.5    
    ## [29] backports_1.0.5  scales_0.4.1     htmltools_0.3.5  rvest_0.3.2     
    ## [33] assertthat_0.1   mnormt_1.5-5     colorspace_1.3-2 stringi_1.1.2   
    ## [37] lazyeval_0.2.0   munsell_0.4.3    broom_0.4.1

### R basics

-   R is a language?
-   Dynamic programming language
-   Do not need compilation.
-   Different from other languages such as C, modern Fortran, Java that require compilation

### Availability

-   Base R and R core packages can be downloaded from
-   Comprehensive R Archive Network (CRAN)
-   Available in Windows/Linux/Mac0
-   cran.r-project.org
-   How to interact with R?
-   RGUI RStudio (preferred for the class)

### RStudio basics

-   RStudio is a RGUI
-   It started that way, now it is much more than a GUI
-   R is the main program

### Data types in R

-   six basic types of atomic vectors:
-   doubles, integers, characters, logicals, complex, and raw
-   last two are not very important and we will not discuss further

``` r
complex(1,2)
```

    ## [1] 2+0i

``` r
raw(2) # bytes of numbers
```

    ## [1] 00 00

#### Integer variables

``` r
ia <- 1L 
ia1 <- 1
class(ia)
```

    ## [1] "integer"

``` r
typeof(ia)
```

    ## [1] "integer"

``` r
class(ia1)
```

    ## [1] "numeric"

``` r
typeof(ia1)
```

    ## [1] "double"

#### Double variables

``` r
ra <- runif(10)
typeof(ra)
```

    ## [1] "double"

``` r
class(ra)
```

    ## [1] "numeric"

#### Character variables

``` r
ca <- c("Tom", "cat")
typeof(ca)
```

    ## [1] "character"

``` r
class(ca)
```

    ## [1] "character"

#### Let us talk about attributes

``` r
ia <- 1L 
names(ia) <- "id"
ia
```

    ## id 
    ##  1

#### Other types, matrix

``` r
M <- matrix(1:6, 3, 2)
dim(M)
```

    ## [1] 3 2

``` r
args(matrix)
```

    ## function (data = NA, nrow = 1, ncol = 1, byrow = FALSE, dimnames = NULL) 
    ## NULL

#### R as a simple calculator

2 \* 3

if R doesnt recognize a code, it displays a + and waits for you

``` r
2 *  
```

Run the following line. you will get an error message. Why?

``` r
10 % 5   
```

### Everything is a vector object in R

-   Variable names should not contain number, no underscore etc.
-   Don't mix numbers and character in a vector
-   If you mix data types (coersion; un-expected outcomes)

``` r
aa <- 22.7

aa = 1 # DO not use not standard

aa + 2
```

    ## [1] 3

``` r
sqrt(aa+1)
```

    ## [1] 1.414214

``` r
aa/3
```

    ## [1] 0.3333333

``` r
ages<-c(1,2,3,4) # another way to create vectors
ages
```

    ## [1] 1 2 3 4

``` r
ages+3   # ages of kids after 3 years 
```

    ## [1] 4 5 6 7

``` r
         # scalar is a zero vector
ages
```

    ## [1] 1 2 3 4

RStudio environment pane displayes the stored variables

### What are acceptable and non acceptable variable names in R ?

| No    | Yes  |
|:------|:-----|
| 1run  | run1 |
| b$    | b    |
| ^mean | mean |
| !var1 | var1 |

### Variable names are case-sensitive and can be over-written

``` r
var1 <- 2
VAR1 <- 1 
(var1 <- 100) # overwrite 
```

    ## [1] 100

### List the variables

Hint: You can also use the Global Environment pane in RStudio for extracting this information

``` r
ls() # to see what variables you have so far
```

    ##  [1] "aa"   "ages" "ca"   "df"   "ia"   "ia1"  "M"    "ncsv" "No"   "ra"  
    ## [11] "tcsv" "var1" "VAR1" "Yes"

``` r
list.files()  # to see the list of files
```

    ##  [1] "1-TidyingData-R-RStudio-Intro.Rmd"
    ##  [2] "2-TidyingData-TBL-TIDYING.Rmd"    
    ##  [3] "3-TidyingData-Date-Time.Rmd"      
    ##  [4] "4-TidyingData-ReprodResearch.Rmd" 
    ##  [5] "5-TidyingData-FinalExercise.Rmd"  
    ##  [6] "Data"                             
    ##  [7] "Images"                           
    ##  [8] "MyStuff"                          
    ##  [9] "R-RStudio-InstallationInstrns"    
    ## [10] "Readme"                           
    ## [11] "README.md"                        
    ## [12] "TidyingData-figure"               
    ## [13] "TidyingData-R-RStudio-Intro_files"

### For the following section, let us use a 6-sided die and do some Data analysis.

First let us create a die object

``` r
die <- 1:6 # 6 sided die
```

### Let us do some Math with our Die

Notice the vector math

``` r
die + 2
```

    ## [1] 3 4 5 6 7 8

``` r
die/2
```

    ## [1] 0.5 1.0 1.5 2.0 2.5 3.0

``` r
die * die
```

    ## [1]  1  4  9 16 25 36

### Let us watch out for recycling

``` r
die + 1:2
```

    ## [1] 2 4 4 6 6 8

### Let us explore built-in functions using our Die

``` r
sum(die)
```

    ## [1] 21

``` r
mean(die)
```

    ## [1] 3.5

### How to get help in R?

``` r
?sum
```

### Stored constants

``` r
pi # not PI
```

    ## [1] 3.141593

### let us round numbers

``` r
round(pi, 10) # what happened here
```

    ## [1] 3.141593

``` r
round(pi, 2)
```

    ## [1] 3.14

``` r
round(pi, digits = 9)
```

    ## [1] 3.141593

``` r
signif(pi, 3) 
```

    ## [1] 3.14

``` r
pvalue <- 0.003 
round(pvalue, 2)  # [1] 0
```

    ## [1] 0

``` r
signif(pvalue, 2) # [1] 0.003
```

    ## [1] 0.003

``` r
evalue <- 1.02342E-06 
signif(evalue,3)
```

    ## [1] 1.02e-06

``` r
 round(evalue,3)
```

    ## [1] 0

### How to find the arguments for a built-in function?

``` r
args(round)
```

    ## function (x, digits = 0) 
    ## NULL

``` r
args(plot)
```

    ## function (x, y, ...) 
    ## NULL

### <span style="color:green">R-basic Exercise-1</span>

-   Find out what the function sample does? let us sample a die by rolling 3 times in R.

#### What is the issue with the following command?

``` r
sample(die, size = 7)
```

### Can we change the default of sample function?

``` r
p <- c(rep(0.01,5), 0.95)
sample(x = die, size = 10, replace = TRUE, prob = p)
```

    ##  [1] 6 6 6 6 6 6 6 6 6 6

### Do we always have to use the arguments name? What if we dont?

``` r
sample(die, 10, replace = TRUE)
```

    ##  [1] 2 4 1 3 3 4 4 1 6 4

``` r
sample(die, 10, TRUE) #  define them explicitely
```

    ##  [1] 2 4 6 4 5 6 3 1 6 2

``` r
sample(x = die, size = 6, replace = TRUE)
```

    ## [1] 1 1 4 5 5 1

### Let us roll the die multiple times

``` r
# First roll
sample(x = die, size = 2, replace = TRUE) # def prob
```

    ## [1] 6 2

``` r
# one more roll
sample(x = die, size = 2, replace = TRUE) # def prob
```

    ## [1] 3 2

### Random numbers

``` r
unif_rand <- runif(10)
args(round)
```

    ## function (x, digits = 0) 
    ## NULL

### Function in R

-   Function constructor (like C++) has three parts
-   1.  name
-   1.  body (of code)
-   1.  arguments
-   function() { \#\#\# }

### Let us build a function

``` r
dist <- function(a, b) {
  distsq <- sum( (b - a)^2 )
  sqrt(distsq)
}
```

Let us call the function with inputs

``` r
a <- c(1,2)
b <- c(3,3)

dist(a,b)
```

    ## [1] 2.236068

### Now let us turn the following lines into a function in RStudio

``` r
#Use RStudio to turn the following line into a function called dist2

distsq <- sum( (b - a)^2 )
sqrt(distsq)
```

    ## [1] 2.236068

### Installing and using packages in R

-   R comes with core packages (basic). There are several packages available for R (Ex. Tidyverse)
-   How can I install a package? <code>install.packages("foreign") \# to install foreign package </code>
-   After installation, you have load the package, using the following command
    <pre> <code> 
    library(foreign) 
    help(package=foreign)
    </code> </pre>

After using a package, use
<pre>detach(foreign)</pre>
to remove a package (ex. foreign package) from the workspace.

Use
<pre> SessionInfo() </pre>
to get a detailed description of the attached packages and R session. R commands can be either typed or loaded from a file using source command.

Here is an example of installing a package called randomForest and updating package(s)

``` r
install.packages("randomForest")
library(randomForest)
## multiple packages
update.packages(c("randomForest","tidyverse"))
```

### Debugging in R

``` r
mysum <- function(a,b) {
  sum( (bb - a)^2 )
}

dist <- function(a, b) {
  distsq <- mysum(a,b)
  sqrt(distsq)
}

# use of RStudio bebug or traceback function
dist(a,b)
```

### plots

Here we will explore the basic plots in R. Watch out for future graphics workshop using R, where we will explore the new and powerful ggplot function For now, we will focus on simple plots.

``` r
x <- runif(1000)
hist(x)
```

![](1-TidyingData-R-RStudio-Intro_files/figure-markdown_github/unnamed-chunk-37-1.png)

``` r
hist(x, main = "Histogram of Uniform Random Numbers")
```

![](1-TidyingData-R-RStudio-Intro_files/figure-markdown_github/unnamed-chunk-37-2.png)

``` r
boxplot(x, col = "red")
```

![](1-TidyingData-R-RStudio-Intro_files/figure-markdown_github/unnamed-chunk-37-3.png)

### Read and Write, compressed file

write.csv(lcancer, file = bzfile("data/lcaner.csv.bz2"), row.names = FALSE)

### Some useful functions

Let us use the cars dataset to show some important R commands

``` r
summary(cars)
```

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00

``` r
str(cars)
```

    ## 'data.frame':    50 obs. of  2 variables:
    ##  $ speed: num  4 4 7 7 8 9 10 10 10 11 ...
    ##  $ dist : num  2 10 4 22 16 10 18 26 34 17 ...

### Single bracket

``` r
cars[1,]
```

    ##   speed dist
    ## 1     4    2

``` r
cars[1:5,]
```

    ##   speed dist
    ## 1     4    2
    ## 2     4   10
    ## 3     7    4
    ## 4     7   22
    ## 5     8   16

``` r
cars[1,]
```

    ##   speed dist
    ## 1     4    2

``` r
cars[,1] # vector
```

    ##  [1]  4  4  7  7  8  9 10 10 10 11 11 12 12 12 12 13 13 13 13 14 14 14 14
    ## [24] 15 15 15 16 16 17 17 17 18 18 18 18 19 19 19 20 20 20 20 20 22 23 24
    ## [47] 24 24 24 25

``` r
class(cars[,1])
```

    ## [1] "numeric"

``` r
class(cars)
```

    ## [1] "data.frame"

``` r
nrow(cars)
```

    ## [1] 50

``` r
length(cars$speed)
```

    ## [1] 50

``` r
min_speed <- min(cars$speed)
min_speed
```

    ## [1] 4

``` r
max(cars$speed)
```

    ## [1] 25

``` r
cars[min_speed,] # can be easily done using dplyr
```

    ##   speed dist
    ## 4     7   22

``` r
filter(cars, speed > 20)
```

    ##   speed dist
    ## 1    22   66
    ## 2    23   54
    ## 3    24   70
    ## 4    24   92
    ## 5    24   93
    ## 6    24  120
    ## 7    25   85

### Accessing values in data frames

``` r
names(cars)
```

    ## [1] "speed" "dist"

``` r
cars$speed # vector
```

    ##  [1]  4  4  7  7  8  9 10 10 10 11 11 12 12 12 12 13 13 13 13 14 14 14 14
    ## [24] 15 15 15 16 16 17 17 17 18 18 18 18 19 19 19 20 20 20 20 20 22 23 24
    ## [47] 24 24 24 25

``` r
cars$dist 
```

    ##  [1]   2  10   4  22  16  10  18  26  34  17  28  14  20  24  28  26  34
    ## [18]  34  46  26  36  60  80  20  26  54  32  40  32  40  50  42  56  76
    ## [35]  84  36  46  68  32  48  52  56  64  66  54  70  92  93 120  85

If you noticed that data.frame has unique data type for each column. If I want to create an object with mixed types. What I need is a list

``` r
mylist <- list(a = 1:10, b = LETTERS[1:10], c = 11:20L)
mylist
```

    ## $a
    ##  [1]  1  2  3  4  5  6  7  8  9 10
    ## 
    ## $b
    ##  [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J"
    ## 
    ## $c
    ##  [1] 11 12 13 14 15 16 17 18 19 20

``` r
mylist[[1]]
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
mylist$a
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

### Not commonly used data types

``` r
INF<-3/0 # Inf or -Inf 
-3/0 
```

    ## [1] -Inf

``` r
#diff between Inf and NA (not a number) 
!is.na(Inf)
```

    ## [1] TRUE

``` r
# what is then Inf?
is.finite(INF)
```

    ## [1] FALSE

``` r
is.infinite(INF)
```

    ## [1] TRUE

### coercion

``` r
x<-seq(1:10)
x
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
sum(x) # 55
```

    ## [1] 55

``` r
sum(x>5) # 5
```

    ## [1] 5

``` r
#why? coercion
x>5  # logical T or F
```

    ##  [1] FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE

``` r
# sum them 
sum(x>5) # you get 5 sum of  5 1s 
```

    ## [1] 5

``` r
#if you want the sum of their values

sum(x[x>5])
```

    ## [1] 40

### some very useful functions

-apply, lapply, sapply and tapply

#### apply

-   apply operates on arrays (2D, 3D; ex matrices)

``` r
# let us construct a 6 x 5 matrix
X <- matrix(rnorm(30), nrow=6, ncol=5 )

#or
#X <- (rnorm(30), 6, 5 )
# I prefer the previous form
```

If we want to sum up the columns, you can use apply function. Let us first learn the syntax of the function by typing <span style="color:red">?apply</span>

``` r
apply(X, 2, sum)
```

    ## [1]  2.1583510 -5.8446743  2.2729479  0.1641634  2.6130564

### <span style="color:green">Apply Exercise-1</span>

-   What object do you get back from apply function? Explore the question using the previous example.

#### lapply

-   input objects for lapply could be DF, lists or vectors
-   output is always a list

``` r
A <- matrix(rnorm(30), nrow=6, ncol=5 ) 
B <- matrix(rnorm(20), nrow=2, ncol=10 ) 
C <- matrix(rnorm(36), nrow=6, ncol=6 ) 

MyList <- list(A, B, C)
```

To sum up all the columns in each of the matrices, we can write a code like shown below

``` r
# Note the "[" is a separator
# The following line extracts first row from all matrices
lapply(MyList,"[",2, 1)
```

    ## [[1]]
    ## [1] 0.4379665
    ## 
    ## [[2]]
    ## [1] 0.4314612
    ## 
    ## [[3]]
    ## [1] 0.1533705

##### sapply

-   sapply() is the cleaned-up (s:simplify) version of apply function
-   Also sapply() is just a wrapper to lapply()

Let us do the same lapply() function above

``` r
sapply(MyList,"[", 2, 1, simplify= F) # returns a List
```

    ## [[1]]
    ## [1] 0.4379665
    ## 
    ## [[2]]
    ## [1] 0.4314612
    ## 
    ## [[3]]
    ## [1] 0.1533705

``` r
sapply(MyList,"[", 2, 1, simplify= T) # returns a vector
```

    ## [1] 0.4379665 0.4314612 0.1533705

#### tapply

Let us use tapply on mpg dataset from ggplot2

``` r
tapply(mpg$hwy, mpg$cyl, mean)
```

    ##        4        5        6        8 
    ## 28.80247 28.75000 22.82278 17.62857

#### Related function to apply() function.

NEED TO FILL IN

Finally Cleaning up
===================

``` r
objects() # what vars do you have in your env
search() #what is attached
#to remove, use rm(object)
detach(dataframe) 
```

In the tidyverse the commonly returning objects are not data.frame but tibbles. So, let us introduce tibble in the next section.
