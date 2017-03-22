BTEP-R-RStudio-Intro
================
Drs. Sarangan Ravichandran and Randall Johnson
February 26, 2017

### Cleaning up

Let us clean up the environment and set a working directory. This will clear all the variables and start fresh. If you want to follow on, then we suggest you to run the following line.

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
```

### Quick tour of RStudio

We will be using RStudio as the main software for the workshp. Let us do a quick live tour of RStudio. We will cover the following useful tools accessible throug RStudio.

#### Tools

-   Pane (View --&gt; Pane); Option that we are using is "Console on Right"
-   Tools --&gt; Install Packages
-   Tools --&gt; Global Options
-   Session --&gt; Set Working Directory
-   Optons --&gt; R Session
-   File --&gt; Import DataSet

![](Images/RStudioIntro.png)

### Getting the data inside R via RStudio

Let us introduce R/R-Studio Data Import with a Import Dataset and Command-line options

![](Images/RS-ImportDataset.png)

The following few lines will explain how to read in a data file via R command-line

Please note that we will be using **readr** function for this section. Note that read\_csv is different than read.csv

-   read\_csv(), read\_csv2() \# read\_csv2 and read\_csv are same except for what options are default
-   the returning objects from read\_csv and read.csv are different (DF vs tibbles)
-   read\_tsv()
-   read\_delim()

Let us do some examples
-----------------------

Watch out how the column names are displayed and additional information that you get from read\_csv Also note the number of rows are displayed in read\_csv compared to read.csv

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

What happens if your dataset has a metadata (indicated by \# ) as the first line followed by the column names

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

### Why we insist on using readr::read\_csv than read.csv?

-   Speed (~ 10x)
-   Output from readr is Tibbles (we will expand on this later)
-   Base R taps into OS where it is executed. But readr functions are OS independent and hence reproducible

### Import Exercise-1 (Hint: To find out where you are, use the getwd command)

For this exercise, we will be using the data set, nss15.tsv, downloaded from <https://www.cpsc.gov>

you can get and set a working directory by the following commands:

``` r
getwd()
setwd("YOUR_DIR"")
```

To get a detailed description of the attached packages and R session
--------------------------------------------------------------------

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
    ## [1] knitr_1.15.1    dplyr_0.5.0     purrr_0.2.2     readr_1.0.0    
    ## [5] tidyr_0.6.1     tibble_1.2      ggplot2_2.2.1   tidyverse_1.1.1
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_0.12.8      plyr_1.8.4       forcats_0.2.0    tools_3.3.2     
    ##  [5] digest_0.6.11    jsonlite_1.2     lubridate_1.6.0  evaluate_0.10   
    ##  [9] nlme_3.1-128     gtable_0.2.0     lattice_0.20-34  psych_1.6.12    
    ## [13] DBI_0.5-1        yaml_2.1.14      parallel_3.3.2   haven_1.0.0     
    ## [17] xml2_1.1.0       stringr_1.1.0    httr_1.2.1       hms_0.3         
    ## [21] rprojroot_1.2    grid_3.3.2       R6_2.2.0         readxl_0.1.1    
    ## [25] foreign_0.8-67   rmarkdown_1.3    modelr_0.1.0     reshape2_1.4.2  
    ## [29] magrittr_1.5     backports_1.0.5  scales_0.4.1     htmltools_0.3.5 
    ## [33] rvest_0.3.2      assertthat_0.1   mnormt_1.5-5     colorspace_1.3-2
    ## [37] stringi_1.1.2    lazyeval_0.2.0   munsell_0.4.3    broom_0.4.1

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

### simple calculator

2 \* 3

if R doesnt recognize a code, it displays a + and waits for you

type the following in command prompt, you will get a error message. Explain why you

``` r
2 *  
```

``` r
- run the following line. you will get an error message. Why? 
Error: unexpected input in "10 % 5" 

10 % 5 
```

### Everything is an vector object in R

-   Variable names should not contain number, no underscore etc.
-   Don't mix numbers and character in a vector
-   If you mix coercion (un expected outcomes)

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

RStudio environment pane now displays the variable.

### What are acceptable and not acceptable variable names

| No    | Yes  |
|:------|:-----|
| 1run  | run1 |
| b$    | b    |
| ^mean | mean |
| !var1 | var1 |

### Variable names are case-sensitive and can be

    over-written 

``` r
var1 <- 2
VAR1 <- 1 
(var1 <- 100) # overwrite 
```

    ## [1] 100

### List the variables (you can also use the Global Environment pane in RStudio for this)

``` r
ls() # to see what variables you have so far
```

    ## [1] "aa"   "ages" "df"   "ncsv" "No"   "tcsv" "var1" "VAR1" "Yes"

``` r
list.files()  # to see the list of files
```

    ##  [1] "BTEP-Class-TidyingData-05-16-2017.md"
    ##  [2] "Data"                                
    ##  [3] "Images"                              
    ##  [4] "MyStuff"                             
    ##  [5] "R-RStudio-InstallationInstrns"       
    ##  [6] "Readme"                              
    ##  [7] "README.md"                           
    ##  [8] "TidyingData-Date-Time.md"            
    ##  [9] "TidyingData-Date-Time.Rmd"           
    ## [10] "TidyingData-figure"                  
    ## [11] "TidyingData-Handson.md"              
    ## [12] "TidyingData-Handson.Rmd"             
    ## [13] "TidyingData-R-RStudio-Intro.md"      
    ## [14] "TidyingData-R-RStudio-Intro.Rmd"     
    ## [15] "TidyingData-R-RStudio-Intro_files"   
    ## [16] "TidyingData-RegEx.md"                
    ## [17] "TidyingData-RegEx.Rmd"               
    ## [18] "TidyingData-Rmd-Intro.md"            
    ## [19] "TidyingData-Rmd-Intro.Rmd"           
    ## [20] "TidyingData.md"                      
    ## [21] "TidyingData.Rpres"

Data analysis without a die?
============================

``` r
die <- 1:6 # 6 sided die
```

Math with die
=============

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

### Let us watch out for recycling in

``` r
die + 1:2
```

    ## [1] 2 4 4 6 6 8

### Built-in function

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

### How to find the arguments for a built-in function

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

### Exercise 2: Find out what the function sample does?

let us sample a die by rolling 3 times

### What is the issue with the following command?

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

    ##  [1] 6 4 3 3 6 4 2 5 4 4

``` r
sample(die, 10, TRUE) #  define them explicitely
```

    ##  [1] 6 1 1 4 3 2 6 3 3 4

``` r
sample(x = die, size = 6, replace = TRUE)
```

    ## [1] 1 3 5 2 2 3

### Let us roll the die multiple times

``` r
# First roll
sample(x = die, size = 2, replace = TRUE) # def prob
```

    ## [1] 3 1

``` r
# one more roll
sample(x = die, size = 2, replace = TRUE) # def prob
```

    ## [1] 5 5

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

### Now let us turn the following lines into a function in RStudion

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

### Integer variables

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

### Double variables

``` r
ra <- runif(10)
typeof(ra)
```

    ## [1] "double"

``` r
class(ra)
```

    ## [1] "numeric"

### Character variables

``` r
ca <- c("Tom", "cat")
typeof(ca)
```

    ## [1] "character"

``` r
class(ca)
```

    ## [1] "character"

### Let us talk about attributes

``` r
ia <- 1L 
names(ia) <- "id"
ia
```

    ## id 
    ##  1

### Other types, matrix

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

### plots

``` r
x <- runif(1000)
hist(x)
```

![](TidyingData-R-RStudio-Intro_files/figure-markdown_github/unnamed-chunk-36-1.png)

``` r
hist(x, main = "Histogram of Uniform Random Numbers")
```

![](TidyingData-R-RStudio-Intro_files/figure-markdown_github/unnamed-chunk-36-2.png)

``` r
boxplot(x, col = "red")
```

![](TidyingData-R-RStudio-Intro_files/figure-markdown_github/unnamed-chunk-36-3.png)

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
filter(cars, speed > 10)
```

    ##    speed dist
    ## 1     11   17
    ## 2     11   28
    ## 3     12   14
    ## 4     12   20
    ## 5     12   24
    ## 6     12   28
    ## 7     13   26
    ## 8     13   34
    ## 9     13   34
    ## 10    13   46
    ## 11    14   26
    ## 12    14   36
    ## 13    14   60
    ## 14    14   80
    ## 15    15   20
    ## 16    15   26
    ## 17    15   54
    ## 18    16   32
    ## 19    16   40
    ## 20    17   32
    ## 21    17   40
    ## 22    17   50
    ## 23    18   42
    ## 24    18   56
    ## 25    18   76
    ## 26    18   84
    ## 27    19   36
    ## 28    19   46
    ## 29    19   68
    ## 30    20   32
    ## 31    20   48
    ## 32    20   52
    ## 33    20   56
    ## 34    20   64
    ## 35    22   66
    ## 36    23   54
    ## 37    24   70
    ## 38    24   92
    ## 39    24   93
    ## 40    24  120
    ## 41    25   85

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

-tapply, sapply, lapply

Finally Cleaning up
===================

``` r
objects() # what vars do you have in your env
search() #what is attached
#to remove, use rm(object)
detach(dataframe) 
```

In the tidyverse the commonly returning objects are not data.frame but tibbles. So, let us introduce tibble in this section.

Tibble
------

What is tibble?

-   modern way or loooking at the traditional data.frame
-   you will get a lot more useful information than the data.frames
-   tibble is part of tibble package and part of the core tidyverse package

To get help, use

``` r
?tibble
vignette("tibble")
```

How to create a tibble?

``` r
tibble(
  x = 1:5, 
  y = LETTERS[1:5], 
  z = x^2 + 20
)
```

    ## # A tibble: 5 × 3
    ##       x     y     z
    ##   <int> <chr> <dbl>
    ## 1     1     A    21
    ## 2     2     B    24
    ## 3     3     C    29
    ## 4     4     D    36
    ## 5     5     E    45

What is the difference between the R regular data.frame and tibble (data\_frame)?

``` r
employee <- c('John Wayne','Peter Doe','Esther Julie')
salary <- c(20000, 23400, 26800)
startdate <- as.Date(c('2016-12-1','2007-3-25','2016-3-14'))
df <- data.frame(employee, salary, startdate)
df
```

    ##       employee salary  startdate
    ## 1   John Wayne  20000 2016-12-01
    ## 2    Peter Doe  23400 2007-03-25
    ## 3 Esther Julie  26800 2016-03-14

``` r
as_tibble(df)
```

    ## # A tibble: 3 × 3
    ##       employee salary  startdate
    ##         <fctr>  <dbl>     <date>
    ## 1   John Wayne  20000 2016-12-01
    ## 2    Peter Doe  23400 2007-03-25
    ## 3 Esther Julie  26800 2016-03-14

Let us create a data.frame and a tibble.

``` r
df1 <- data.frame( Color = "Red")
tb1 <-tibble(Color = "Red")
```

Exercise:
---------

If you type the following commmands, what will you get and explain your reasoning:

``` r
df1$C
```

    ## [1] Red
    ## Levels: Red

``` r
tb1$C
```

    ## Warning: Unknown column 'C'

    ## NULL

``` r
class(df1$Color)
```

    ## [1] "factor"

``` r
class(tb1$Color)
```

    ## [1] "character"

Also, speculate on the type of object that you will get from each of these above two operations?

The above explains traditional R data.frame is helpful in filling in the missing information. Also how data.frame modifies the variable type without asking (ex Character to Factor)

Where can this go?
------------------

purr::map\_dbl(mtcars, mean) purrr:map\_dbl(mtcars, mean)

tb1 &lt;- as.tibble( Color = "red") tb1$C

you can coerce regular R data frame into tibble. Let us look at the R dataset, cars. Let us learn about cars datset

<pre> <code>
  ?cars
</code></pre>
Let us find out what class cars object belongs to and how to convert cars data frame into tibbles object. Note that

``` r
class(cars)
```

    ## [1] "data.frame"

``` r
as_tibble(cars)
```

    ## # A tibble: 50 × 2
    ##    speed  dist
    ##    <dbl> <dbl>
    ## 1      4     2
    ## 2      4    10
    ## 3      7     4
    ## 4      7    22
    ## 5      8    16
    ## 6      9    10
    ## 7     10    18
    ## 8     10    26
    ## 9     10    34
    ## 10    11    17
    ## # ... with 40 more rows

``` r
head(cars) #otherwise you get all 50 rows
```

    ##   speed dist
    ## 1     4    2
    ## 2     4   10
    ## 3     7    4
    ## 4     7   22
    ## 5     8   16
    ## 6     9   10

Why Tibble?
-----------

-   Tibble doesnt change the inputs. Ex. strings to factors
-   Doesnt add new names or modify the inputs
-   For example, Tibble never converts strings to factors

What is tribble
---------------

-   transposed tibble, tribble()
-   small data in readable form
-   column headings are shown as formulas ( ie ~ )
-   nice format
-   no need to explicitely use head command (Ex. head cars)

``` r
tribble(
  ~x, ~y, ~z,
  #--|--|----
  "Male", 187, 210,
  "Female", 190, 150
)
```

    ## # A tibble: 2 × 3
    ##        x     y     z
    ##    <chr> <dbl> <dbl>
    ## 1   Male   187   210
    ## 2 Female   190   150

Let us create a little bit complicated tibble note that lubridate gives the current time

``` r
t2 <- tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)
```

``` r
t2
```

    ## # A tibble: 1,000 × 5
    ##                      a          b     c          d     e
    ##                 <dttm>     <date> <int>      <dbl> <chr>
    ## 1  2017-03-23 02:16:51 2017-04-10     1 0.45916691     y
    ## 2  2017-03-22 16:30:06 2017-03-28     2 0.36354433     p
    ## 3  2017-03-22 19:30:55 2017-03-24     3 0.88450692     b
    ## 4  2017-03-22 16:00:10 2017-04-08     4 0.07851846     b
    ## 5  2017-03-23 08:00:59 2017-03-24     5 0.25655558     u
    ## 6  2017-03-22 15:17:22 2017-04-17     6 0.29870471     e
    ## 7  2017-03-23 08:04:27 2017-04-15     7 0.98890314     m
    ## 8  2017-03-22 22:40:57 2017-04-04     8 0.66024471     t
    ## 9  2017-03-23 04:07:07 2017-04-04     9 0.84927565     w
    ## 10 2017-03-22 11:26:53 2017-04-12    10 0.49800310     l
    ## # ... with 990 more rows

You can change the defaults of tibble display with options.

``` r
options(tibble.print_max = 10, tibble.print_min = 6)
t2
```

    ## # A tibble: 1,000 × 5
    ##                     a          b     c          d     e
    ##                <dttm>     <date> <int>      <dbl> <chr>
    ## 1 2017-03-23 02:16:51 2017-04-10     1 0.45916691     y
    ## 2 2017-03-22 16:30:06 2017-03-28     2 0.36354433     p
    ## 3 2017-03-22 19:30:55 2017-03-24     3 0.88450692     b
    ## 4 2017-03-22 16:00:10 2017-04-08     4 0.07851846     b
    ## 5 2017-03-23 08:00:59 2017-03-24     5 0.25655558     u
    ## 6 2017-03-22 15:17:22 2017-04-17     6 0.29870471     e
    ## # ... with 994 more rows

You can also use the following tibble option to show all columns

``` r
options(tibble.width = Inf)
# more options available at 
package?tibble
```

How to extract the columns or rows of tibble?

``` r
head(t2$a)
```

    ## [1] "2017-03-23 02:16:51 EDT" "2017-03-22 16:30:06 EDT"
    ## [3] "2017-03-22 19:30:55 EDT" "2017-03-22 16:00:10 EDT"
    ## [5] "2017-03-23 08:00:59 EDT" "2017-03-22 15:17:22 EDT"

``` r
has_name(t2, "b")
```

    ## [1] TRUE

``` r
getOption("tibble.max_extra_cols")
```

    ## NULL

how to add a row of a tibble in a specific place?

original t2

``` r
t2
```

    ## # A tibble: 1,000 × 5
    ##                     a          b     c          d     e
    ##                <dttm>     <date> <int>      <dbl> <chr>
    ## 1 2017-03-23 02:16:51 2017-04-10     1 0.45916691     y
    ## 2 2017-03-22 16:30:06 2017-03-28     2 0.36354433     p
    ## 3 2017-03-22 19:30:55 2017-03-24     3 0.88450692     b
    ## 4 2017-03-22 16:00:10 2017-04-08     4 0.07851846     b
    ## 5 2017-03-23 08:00:59 2017-03-24     5 0.25655558     u
    ## 6 2017-03-22 15:17:22 2017-04-17     6 0.29870471     e
    ## # ... with 994 more rows

``` r
    aa = lubridate::today()
    bb = lubridate::now()
    cc = 1:1
    dd = runif(1)
    ee = sample(letters, 1, replace = TRUE)
    print(aa); print(bb); print(cc); print(dd); print(ee)
```

    ## [1] "2017-03-22"

    ## [1] "2017-03-22 09:37:08 EDT"

    ## [1] 1

    ## [1] 0.8802539

    ## [1] "i"

``` r
t2 %>% 
  add_row(
    a = aa, 
    b = bb,
    c = cc,
    d = dd,
    e = ee, .before = 2  # note the dot in ".before = 2"
)
```

    ## # A tibble: 1,001 × 5
    ##                     a          b     c          d     e
    ##                <dttm>     <date> <int>      <dbl> <chr>
    ## 1 2017-03-23 02:16:51 2017-04-10     1 0.45916691     y
    ## 2 2017-03-21 20:00:00 2017-03-22     1 0.88025387     i
    ## 3 2017-03-22 16:30:06 2017-03-28     2 0.36354433     p
    ## 4 2017-03-22 19:30:55 2017-03-24     3 0.88450692     b
    ## 5 2017-03-22 16:00:10 2017-04-08     4 0.07851846     b
    ## 6 2017-03-23 08:00:59 2017-03-24     5 0.25655558     u
    ## # ... with 995 more rows

After the change

``` r
t2
```

    ## # A tibble: 1,000 × 5
    ##                     a          b     c          d     e
    ##                <dttm>     <date> <int>      <dbl> <chr>
    ## 1 2017-03-23 02:16:51 2017-04-10     1 0.45916691     y
    ## 2 2017-03-22 16:30:06 2017-03-28     2 0.36354433     p
    ## 3 2017-03-22 19:30:55 2017-03-24     3 0.88450692     b
    ## 4 2017-03-22 16:00:10 2017-04-08     4 0.07851846     b
    ## 5 2017-03-23 08:00:59 2017-03-24     5 0.25655558     u
    ## 6 2017-03-22 15:17:22 2017-04-17     6 0.29870471     e
    ## # ... with 994 more rows

Subsetting
----------

-   $ by name
-   

``` r
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

df$x
```

    ## [1] 0.5943860 0.3927596 0.9933660 0.2225172 0.4055647

``` r
df[[1]]
```

    ## [1] 0.5943860 0.3927596 0.9933660 0.2225172 0.4055647

Can you use Tibble in a pipeline?

``` r
df %>% .$x   
```

    ## [1] 0.5943860 0.3927596 0.9933660 0.2225172 0.4055647

``` r
df %>% .[["y"]]
```

    ## [1]  0.2218775 -0.9143368 -1.4144202 -0.6028054  0.9161316

What happens if tibble doesnt work with a package? Transform Tibble back to a data.frame using the following command:

``` r
as.data.frame(df)
```

    ##           x          y
    ## 1 0.5943860  0.2218775
    ## 2 0.3927596 -0.9143368
    ## 3 0.9933660 -1.4144202
    ## 4 0.2225172 -0.6028054
    ## 5 0.4055647  0.9161316

Tibble Exercise 1
-----------------

Create a new tibble with the following information: name, age, height, weight, smoker (T or F), Male (True or Fale) compare the tibble with the R data\_frame

Exercise 2
----------

convert iris data set (given to us in data.frame ) to tibble data\_frame

Exercise 3
----------

How can you tell whether the object is a Tibble or not?

Exercise 4 (based on Wickam's book)
-----------------------------------

Partial matching is a big issue with data.frame. df &lt;- data.frame(abc = 1, xyz = "a") df$x df\[, "xyz"\]

### Hands-on Exercise

The datset that we will be using comes from the
National Electronic Injury Surveillance System (NEISS) <https://www.cpsc.gov/research--statistics/neiss-injury-data> Here is a short description of the data file from the NEISS.

*"Each record (case) is separated by a carriage return/line feed, and the fields (parameters and narrative) are separated by a tab character, which you can specify as the delimiter when importing into a spreadsheet or database."*

Before you read in the data, please take a look at the following two files: **NEISS\_SAS\_formats.txt** and **NEISS\_SAS\_variance.txt** These two files will act as the codebook for the data.

Read the data file, **nss15.tsv** file from the sub-folder/directory, **Data** and call the data as **nss15** variable.

Hint: Use the File --&gt; Import --&gt; Data DataSet option to read the file. To remind the data is in a tab-separated format.

Hint: Watch out for the Data Type choices that are suggested to you and choose the appropriate ones

Hint: Please watch out for any warnings or issues while R/Rstudio is reading the files. If you spot any errors, think of how to fix it. After fixing the problems (if any), go back and read the file.

Answer the following questions.

-   How many cases are reported in this dataset?
-   How many covariates this dataset has?
-   Access CPSC Case \# 150620565 and report the following things: What is the age of the patient? What is the Race, weight, Stratum, Sex, Race and Diagnosis
-   How many are more than 100 years old?
-   How many cases were taken to **Children's Hospital**? From the reported cases, get the CPSC case number and age for the 20th entry.
-   Report the number of cases for the month of May? Tell us how many cases were reported for May 13 - May 16, 2015? Use this information to answer the following questions.

1.  What hospitals were the cases went to (provide a table)?
2.  How many were children ( &lt; 5 years)?
3.  provide the proportion of male/female?
4.  What was the race distribution?

Hands-on exercise using Wisconsin Breast Cancer dataset
-------------------------------------------------------

Now, let us read a slightly complicated Breast Cancer dataset. First let us use the import data set drop-down option

![](Images/RS-ImportDataset.png) ![](Images/RS-ImportDataset1.png)

``` r
#wdbc <- read_csv("C:/Users/Ravi/Desktop/BTEP/Data/wdbc.data", col_names = FALSE)

wdbc <- read_csv("Data/wdbc.data", col_names = FALSE)
```

    ## Parsed with column specification:
    ## cols(
    ##   .default = col_double(),
    ##   X1 = col_integer(),
    ##   X2 = col_character()
    ## )

    ## See spec(...) for full column specifications.

``` r
#wdbctry2 <- read_csv("C:/Users/Ravi/Desktop/BTEP/Data/wdbc.data", header = FALSE)
names(wdbc)
```

    ##  [1] "X1"  "X2"  "X3"  "X4"  "X5"  "X6"  "X7"  "X8"  "X9"  "X10" "X11"
    ## [12] "X12" "X13" "X14" "X15" "X16" "X17" "X18" "X19" "X20" "X21" "X22"
    ## [23] "X23" "X24" "X25" "X26" "X27" "X28" "X29" "X30" "X31" "X32"

Let us add column names

``` r
cnames <- c("ID", "Diagnosis", 
            "radius", "Texture", "Perimeter", "area",
            "smoothness", "compactness", "concavity", "concave_points",
            "symmetry","fractaldim",
            "radiusSE", "TextureSE", "PerimeterSE", "areaSE",
            "smoothnessSE", "compactnessSE", "concavitySE", "concave_pointsSE",
            "symmetrySE","fractaldimSE",
            "radiusW", "TextureW", "PerimeterW", "areaW",
            "smoothnessW", "compactnessW", "concavityW", "concave_pointsW",
            "symmetryW","fractaldimW")

names(wdbc) <- cnames
```

Let us find out how many samples we have in the dataset?

``` r
nrow(wdbc)
```

    ## [1] 569

How many covariates are in the dataset? We can look at the Global environment (top right) window to get the information We can also find that out by typing the following command:

``` r
ncol(wdbc)
```

    ## [1] 32

\#xtra Ignore for the moment
----------------------------

Including Plots
---------------

You can also embed plots, for example:

![](TidyingData-R-RStudio-Intro_files/figure-markdown_github/pressure-1.png)

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

``` r
with(cars, plot(speed,dist))
```

![cars](TidyingData-R-RStudio-Intro_files/figure-markdown_github/cars-1.png)
