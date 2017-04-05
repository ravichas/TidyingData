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

### <span style="color:green">Tibble Exercise-1</span>

If you type the following commmands, what will you get and explain your reasoning:

``` r
df1$C
tb1$C

class(df1$Color)
class(tb1$Color)
```

Also, speculate on the type of object that you will get from each of these above two operations?

The above explains traditional R data.frame is helpful in filling in the missing information. Also how data.frame modifies the variable type without asking (ex Character to Factor)

### Map function example

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
    ##                      a          b     c         d     e
    ##                 <dttm>     <date> <int>     <dbl> <chr>
    ## 1  2017-04-05 21:29:11 2017-04-25     1 0.9833032     i
    ## 2  2017-04-06 13:21:13 2017-04-26     2 0.3967371     t
    ## 3  2017-04-06 04:53:48 2017-04-24     3 0.9805095     g
    ## 4  2017-04-05 21:05:16 2017-04-19     4 0.5579897     h
    ## 5  2017-04-06 02:01:07 2017-04-25     5 0.6319346     k
    ## 6  2017-04-06 15:03:27 2017-05-02     6 0.1584572     g
    ## 7  2017-04-06 14:04:12 2017-04-06     7 0.8944167     v
    ## 8  2017-04-05 21:21:09 2017-04-16     8 0.8882579     h
    ## 9  2017-04-05 23:54:39 2017-04-26     9 0.3822417     i
    ## 10 2017-04-06 11:19:30 2017-04-15    10 0.8487553     l
    ## # ... with 990 more rows

You can change the defaults of tibble display with options.

``` r
options(tibble.print_max = 10, tibble.print_min = 6)
t2
```

    ## # A tibble: 1,000 × 5
    ##                     a          b     c         d     e
    ##                <dttm>     <date> <int>     <dbl> <chr>
    ## 1 2017-04-05 21:29:11 2017-04-25     1 0.9833032     i
    ## 2 2017-04-06 13:21:13 2017-04-26     2 0.3967371     t
    ## 3 2017-04-06 04:53:48 2017-04-24     3 0.9805095     g
    ## 4 2017-04-05 21:05:16 2017-04-19     4 0.5579897     h
    ## 5 2017-04-06 02:01:07 2017-04-25     5 0.6319346     k
    ## 6 2017-04-06 15:03:27 2017-05-02     6 0.1584572     g
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

    ## [1] "2017-04-05 21:29:11 EDT" "2017-04-06 13:21:13 EDT"
    ## [3] "2017-04-06 04:53:48 EDT" "2017-04-05 21:05:16 EDT"
    ## [5] "2017-04-06 02:01:07 EDT" "2017-04-06 15:03:27 EDT"

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
    ##                     a          b     c         d     e
    ##                <dttm>     <date> <int>     <dbl> <chr>
    ## 1 2017-04-05 21:29:11 2017-04-25     1 0.9833032     i
    ## 2 2017-04-06 13:21:13 2017-04-26     2 0.3967371     t
    ## 3 2017-04-06 04:53:48 2017-04-24     3 0.9805095     g
    ## 4 2017-04-05 21:05:16 2017-04-19     4 0.5579897     h
    ## 5 2017-04-06 02:01:07 2017-04-25     5 0.6319346     k
    ## 6 2017-04-06 15:03:27 2017-05-02     6 0.1584572     g
    ## # ... with 994 more rows

``` r
    aa = lubridate::today()
    bb = lubridate::now()
    cc = 1:1
    dd = runif(1)
    ee = sample(letters, 1, replace = TRUE)
    print(aa); print(bb); print(cc); print(dd); print(ee)
```

    ## [1] "2017-04-05"

    ## [1] "2017-04-05 15:15:41 EDT"

    ## [1] 1

    ## [1] 0.8591092

    ## [1] "n"

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
    ##                     a          b     c         d     e
    ##                <dttm>     <date> <int>     <dbl> <chr>
    ## 1 2017-04-05 21:29:11 2017-04-25     1 0.9833032     i
    ## 2 2017-04-04 20:00:00 2017-04-05     1 0.8591092     n
    ## 3 2017-04-06 13:21:13 2017-04-26     2 0.3967371     t
    ## 4 2017-04-06 04:53:48 2017-04-24     3 0.9805095     g
    ## 5 2017-04-05 21:05:16 2017-04-19     4 0.5579897     h
    ## 6 2017-04-06 02:01:07 2017-04-25     5 0.6319346     k
    ## # ... with 995 more rows

After the change

``` r
t2
```

    ## # A tibble: 1,000 × 5
    ##                     a          b     c         d     e
    ##                <dttm>     <date> <int>     <dbl> <chr>
    ## 1 2017-04-05 21:29:11 2017-04-25     1 0.9833032     i
    ## 2 2017-04-06 13:21:13 2017-04-26     2 0.3967371     t
    ## 3 2017-04-06 04:53:48 2017-04-24     3 0.9805095     g
    ## 4 2017-04-05 21:05:16 2017-04-19     4 0.5579897     h
    ## 5 2017-04-06 02:01:07 2017-04-25     5 0.6319346     k
    ## 6 2017-04-06 15:03:27 2017-05-02     6 0.1584572     g
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

    ## [1] 0.9915810 0.6355919 0.9408978 0.9293142 0.1179778

``` r
df[[1]]
```

    ## [1] 0.9915810 0.6355919 0.9408978 0.9293142 0.1179778

Can you use Tibble in a pipeline?

``` r
df %>% .$x   
```

    ## [1] 0.9915810 0.6355919 0.9408978 0.9293142 0.1179778

``` r
df %>% .[["y"]]
```

    ## [1] 0.8673129 1.0857834 0.5456471 0.2797278 0.6857248

What happens if tibble doesnt work with a package? Transform Tibble back to a data.frame using the following command:

``` r
as.data.frame(df)
```

    ##           x         y
    ## 1 0.9915810 0.8673129
    ## 2 0.6355919 1.0857834
    ## 3 0.9408978 0.5456471
    ## 4 0.9293142 0.2797278
    ## 5 0.1179778 0.6857248

### <span style="color:green">Tibble Exercise-2</span>

Create a new tibble with the following information: name, age, height, weight, smoker (T or F), Male (True or Fale) compare the tibble with the R data\_frame

### <span style="color:green">Tibble Exercise-3</span>

convert iris data set (given to us in data.frame ) to tibble data\_frame

### <span style="color:green">Tibble Exercise-4</span>

How can you tell whether the object is a Tibble or not?

### <span style="color:green">Tibble Exercise-5 (based on Hadley's tutorial) </span>

Partial matching is a big issue with data.frame. df &lt;- data.frame(abc = 1, xyz = "a") df$x df\[, "xyz"\]

### <span style="color:green">Final R-basic exercise</span>

The datset that we will be using for this section comes from the
National Electronic Injury Surveillance System (NEISS) <https://www.cpsc.gov/research--statistics/neiss-injury-data> Here is a short description of the data file from the NEISS.

*"Each record (case) is separated by a carriage return/line feed, and the fields (parameters and narrative) are separated by a tab character, which you can specify as the delimiter when importing into a spreadsheet or database."*

Before you read in the data, please take a look at the following two files: **NEISS\_SAS\_formats.txt** and **NEISS\_SAS\_variance.txt** These two files will act as the codebook for the data.

Read the data file, **nss15.tsv** file from the sub-folder/directory, **Data** and call the data as **nss15** variable.

**Hint:** Use the File --&gt; Import --&gt; Data DataSet option to read the file. To remind the data is in a tab-separated format.

**Hint:** Watch out for the Data Type choices that are suggested to you and choose the appropriate ones

**Hint:** Please watch out for any warnings or issues while R/Rstudio is reading the files. If you spot any errors, think of how to fix it. After fixing the problems (if any), go back and read the file.

Answer the following questions.

-   How many cases are reported in this dataset?
-   How many covariates this dataset has?
-   Access CPSC Case \# 150620565 and report the following things: What is the age of the patient? What is the Race, weight, Stratum, Sex, Race and Diagnosis
-   How many are more than 100 years old?
-   How many cases were taken to **Children's Hospital**? From the reported cases, get the CPSC case number and age for the 20th entry.

### Ignore from here to the end for the moment

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

Including Plots
---------------

You can also embed plots, for example:

![](2-TidyingData-TBL-TIDYING_files/figure-markdown_github/pressure-1.png)

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

``` r
with(cars, plot(speed,dist))
```

![cars](2-TidyingData-TBL-TIDYING_files/figure-markdown_github/cars-1.png)
