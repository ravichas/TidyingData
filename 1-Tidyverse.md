Data Tidying: Tidyverse Basics
================
Drs. Sarangan Ravichandran and Randall Johnson

### Cleaning up

Table of Contents
=================

1.  [Tibbles](#tibbles)

    1.1 [Why tibbles?](#why)

    1.2 [Working with tibbles](#working)

    1.3 [Examples and exercises](#eeTibbles)

2.  [Importing Data](#import)

    2.1 [Comments and metadata](#skip)

    2.2 [Examples and exercises](#eeImport)

<a name="tibbles"></a>Tibbles
=============================

In the tidyverse the commonly returning objects are not data.frame but tibbles, which can be created with either the `tibble()` or `data_frame()` functions.

What is tibble?

-   modern way of looking at the traditional data.frame
-   you will get a lot more useful information than the data.frames
-   tibble is part of tibble package and part of the core tidyverse package

There is a nice vignette for working with tibbles, accessible using this command: `vignette("tibble")`.

How to create a tibble?

``` r
tibble(x = 1:5, 
       y = LETTERS[1:5], 
       z = x^2 + 20)
```

    ## # A tibble: 5 x 3
    ##       x y         z
    ##   <int> <chr> <dbl>
    ## 1     1 A       21.
    ## 2     2 B       24.
    ## 3     3 C       29.
    ## 4     4 D       36.
    ## 5     5 E       45.

What is the differences between the base-R `data.frame` and `tibble` (`data_frame`)?

``` r
(df <- data.frame(employee = c('John Wayne','Peter Doe','Esther Julie'),
                  salary = c(20000, 23400, 26800), 
                  startdate = as.Date(c('2016-12-1','2007-3-25','2016-3-14'))))
```

    ##       employee salary  startdate
    ## 1   John Wayne  20000 2016-12-01
    ## 2    Peter Doe  23400 2007-03-25
    ## 3 Esther Julie  26800 2016-03-14

``` r
as_tibble(df)
```

    ## # A tibble: 3 x 3
    ##   employee     salary startdate 
    ##   <fct>         <dbl> <date>    
    ## 1 John Wayne   20000. 2016-12-01
    ## 2 Peter Doe    23400. 2007-03-25
    ## 3 Esther Julie 26800. 2016-03-14

<a name="why"></a>Why Tibbles?
------------------------------

-   `tibble()` doesn't change the inputs (i.e. it doesn't convert strings to factors).

``` r
data.frame(x = letters[1:5]) %>%
    str() # x converted into a factor
```

    ## 'data.frame':    5 obs. of  1 variable:
    ##  $ x: Factor w/ 5 levels "a","b","c","d",..: 1 2 3 4 5

``` r
data_frame(x = letters[1:5]) %>%
    str() # no auto-conversion
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    5 obs. of  1 variable:
    ##  $ x: chr  "a" "b" "c" "d" ...

-   `tibble()` allows the use of variables within the function, making for neater code.

``` r
data.frame(x = 1:10,
           y = x / 2) %>%
    str()  # doesn't work
```

    ## Error in data.frame(x = 1:10, y = x/2): object 'x' not found

``` r
dat <- data.frame(x = 1:10)
dat$y <- dat$x / 2
str(dat)
```

    ## 'data.frame':    10 obs. of  2 variables:
    ##  $ x: int  1 2 3 4 5 6 7 8 9 10
    ##  $ y: num  0.5 1 1.5 2 2.5 3 3.5 4 4.5 5

``` r
data_frame(x = 1:10,
           y = x / 2) %>%
    str()
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    10 obs. of  2 variables:
    ##  $ x: int  1 2 3 4 5 6 7 8 9 10
    ##  $ y: num  0.5 1 1.5 2 2.5 3 3.5 4 4.5 5

-   `data.frame()` does partial string matching without warning you.

``` r
data.frame(color = "red")$c
```

    ## [1] red
    ## Levels: red

``` r
data_frame(color = "red")$c
```

    ## Warning: Unknown or uninitialised column: 'c'.

    ## NULL

-   The print method for tibbles is more user friendly.

``` r
data(who)

who # this is a tibble
```

    ## # A tibble: 7,240 x 60
    ##    country     iso2  iso3   year new_sp_m014 new_sp_m1524 new_sp_m2534
    ##    <chr>       <chr> <chr> <int>       <int>        <int>        <int>
    ##  1 Afghanistan AF    AFG    1980          NA           NA           NA
    ##  2 Afghanistan AF    AFG    1981          NA           NA           NA
    ##  3 Afghanistan AF    AFG    1982          NA           NA           NA
    ##  4 Afghanistan AF    AFG    1983          NA           NA           NA
    ##  5 Afghanistan AF    AFG    1984          NA           NA           NA
    ##  6 Afghanistan AF    AFG    1985          NA           NA           NA
    ##  7 Afghanistan AF    AFG    1986          NA           NA           NA
    ##  8 Afghanistan AF    AFG    1987          NA           NA           NA
    ##  9 Afghanistan AF    AFG    1988          NA           NA           NA
    ## 10 Afghanistan AF    AFG    1989          NA           NA           NA
    ## # ... with 7,230 more rows, and 53 more variables: new_sp_m3544 <int>,
    ## #   new_sp_m4554 <int>, new_sp_m5564 <int>, new_sp_m65 <int>,
    ## #   new_sp_f014 <int>, new_sp_f1524 <int>, new_sp_f2534 <int>,
    ## #   new_sp_f3544 <int>, new_sp_f4554 <int>, new_sp_f5564 <int>,
    ## #   new_sp_f65 <int>, new_sn_m014 <int>, new_sn_m1524 <int>,
    ## #   new_sn_m2534 <int>, new_sn_m3544 <int>, new_sn_m4554 <int>,
    ## #   new_sn_m5564 <int>, new_sn_m65 <int>, new_sn_f014 <int>,
    ## #   new_sn_f1524 <int>, new_sn_f2534 <int>, new_sn_f3544 <int>,
    ## #   new_sn_f4554 <int>, new_sn_f5564 <int>, new_sn_f65 <int>,
    ## #   new_ep_m014 <int>, new_ep_m1524 <int>, new_ep_m2534 <int>,
    ## #   new_ep_m3544 <int>, new_ep_m4554 <int>, new_ep_m5564 <int>,
    ## #   new_ep_m65 <int>, new_ep_f014 <int>, new_ep_f1524 <int>,
    ## #   new_ep_f2534 <int>, new_ep_f3544 <int>, new_ep_f4554 <int>,
    ## #   new_ep_f5564 <int>, new_ep_f65 <int>, newrel_m014 <int>,
    ## #   newrel_m1524 <int>, newrel_m2534 <int>, newrel_m3544 <int>,
    ## #   newrel_m4554 <int>, newrel_m5564 <int>, newrel_m65 <int>,
    ## #   newrel_f014 <int>, newrel_f1524 <int>, newrel_f2534 <int>,
    ## #   newrel_f3544 <int>, newrel_f4554 <int>, newrel_f5564 <int>,
    ## #   newrel_f65 <int>

``` r
as.data.frame(who) # try printing as a data.frame (output not shown here)
```

Why not use a tibble? There are a few packages that don't get along with tibbles (e.g. the missForest package). In this case, you may need to convert your tibble into a data.frame using `as.data.frame()`.

<a name="working"></a>Working with tibbles
------------------------------------------

Here is a more complicated tibble, consisting of a random start time within +/- 12 hours of now and a random end time within the next 30 days (where "now" is relative to when this code is run).

``` r
# lubridate gives us the now() function
require(lubridate)

twelve_hours <- 43200 # seconds
twenty4_hours <- 86400 # seconds

n <- 1000
set.seed(239847)
(t2 <- tibble(
    start   = now() +                      # random time within +/- 12 hours of now
              runif(n, -twelve_hours, twelve_hours), 
    end     = now() +                      # random time within the next 30 days
              runif(n, 1, 30 * twenty4_hours),
    elapsed = as.numeric(end - start, 
                         units = 'hours'), # hours between time_of_day and day
    l       = sample(letters, n, replace = TRUE)  # some letters
))
```

A tibble: 1,000 x 4
===================

start end elapsed l
<dttm> <dttm> <dbl> <chr> 1 2018-03-13 12:52:29 2018-04-03 13:45:16 505. d
2 2018-03-13 12:25:35 2018-04-11 15:27:53 699. p
3 2018-03-13 13:30:33 2018-03-28 03:42:08 350. f
4 2018-03-13 03:50:04 2018-03-14 06:55:43 27.1 n
5 2018-03-13 12:18:49 2018-04-11 08:16:49 692. q
6 2018-03-13 19:08:21 2018-03-24 09:20:41 254. b
7 2018-03-13 14:10:51 2018-03-21 19:54:57 198. v
8 2018-03-13 04:28:05 2018-04-02 07:16:05 483. f
9 2018-03-13 20:13:53 2018-03-19 08:19:09 132. b
10 2018-03-12 21:48:42 2018-03-17 17:08:11 115. b
\# ... with 990 more rows

### Adding/changing variables

You can add and change variables within a tibble using `mutate()`. The syntax is nearly identical to `tibble()` and `data_frame()`, except it requires the tibble you want to edit as input. For example, if we want to add a new variable to our data\_frame, `t2`:

``` r
(t2 <- mutate(t2,
              case = 1:n <= 500))
```

    ## # A tibble: 1,000 x 5
    ##    start               end                 elapsed l     case 
    ##    <dttm>              <dttm>                <dbl> <chr> <lgl>
    ##  1 2018-03-13 12:52:29 2018-04-03 13:45:16   505.  d     TRUE 
    ##  2 2018-03-13 12:25:35 2018-04-11 15:27:53   699.  p     TRUE 
    ##  3 2018-03-13 13:30:33 2018-03-28 03:42:08   350.  f     TRUE 
    ##  4 2018-03-13 03:50:04 2018-03-14 06:55:43    27.1 n     TRUE 
    ##  5 2018-03-13 12:18:49 2018-04-11 08:16:49   692.  q     TRUE 
    ##  6 2018-03-13 19:08:21 2018-03-24 09:20:41   254.  b     TRUE 
    ##  7 2018-03-13 14:10:51 2018-03-21 19:54:57   198.  v     TRUE 
    ##  8 2018-03-13 04:28:05 2018-04-02 07:16:05   483.  f     TRUE 
    ##  9 2018-03-13 20:13:53 2018-03-19 08:19:09   132.  b     TRUE 
    ## 10 2018-03-12 21:48:42 2018-03-17 17:08:11   115.  b     TRUE 
    ## # ... with 990 more rows

### Adding rows

You can add rows to a tibble, and using the `.before` option will allow you to specify where exactly to add the data (default, i.e. if you don't specify `.before`, is to put the new data at the end of the tibble).

``` r
# see our new row on line 2?
(t2 <- t2 %>%
       add_row(start   = now(),
               end     = now() + 1,
               elapsed = 24,
               l       = 'f',
               .before = 2))
```

    ## # A tibble: 1,001 x 5
    ##    start               end                 elapsed l     case 
    ##    <dttm>              <dttm>                <dbl> <chr> <lgl>
    ##  1 2018-03-13 12:52:29 2018-04-03 13:45:16   505.  d     TRUE 
    ##  2 2018-03-13 08:48:45 2018-03-13 08:48:46    24.0 f     NA   
    ##  3 2018-03-13 12:25:35 2018-04-11 15:27:53   699.  p     TRUE 
    ##  4 2018-03-13 13:30:33 2018-03-28 03:42:08   350.  f     TRUE 
    ##  5 2018-03-13 03:50:04 2018-03-14 06:55:43    27.1 n     TRUE 
    ##  6 2018-03-13 12:18:49 2018-04-11 08:16:49   692.  q     TRUE 
    ##  7 2018-03-13 19:08:21 2018-03-24 09:20:41   254.  b     TRUE 
    ##  8 2018-03-13 14:10:51 2018-03-21 19:54:57   198.  v     TRUE 
    ##  9 2018-03-13 04:28:05 2018-04-02 07:16:05   483.  f     TRUE 
    ## 10 2018-03-13 20:13:53 2018-03-19 08:19:09   132.  b     TRUE 
    ## # ... with 991 more rows

### Subsetting

You can use all the same indexing techniques described for data.frames in the [R/RStudio Intro](https://github.com/ravichas/TidyingData/blob/master/0-RStudio-Intro.md), or you can use one of the wrapper functions from the tidyverse:

-   filter(): Select specific rows from the `tibble`

``` r
# pull all rows where elapsed number of hours is less than 72
# looks like there are 102 observations (rows) that fit that criterion
filter(t2, elapsed < 72)
```

    ## # A tibble: 102 x 5
    ##    start               end                 elapsed l     case 
    ##    <dttm>              <dttm>                <dbl> <chr> <lgl>
    ##  1 2018-03-13 08:48:45 2018-03-13 08:48:46   24.0  f     NA   
    ##  2 2018-03-13 03:50:04 2018-03-14 06:55:43   27.1  n     TRUE 
    ##  3 2018-03-13 20:16:57 2018-03-15 22:20:47   50.1  k     TRUE 
    ##  4 2018-03-12 23:56:47 2018-03-13 13:30:29   13.6  p     TRUE 
    ##  5 2018-03-13 15:26:51 2018-03-15 15:13:55   47.8  v     TRUE 
    ##  6 2018-03-13 16:05:36 2018-03-14 20:50:31   28.7  v     TRUE 
    ##  7 2018-03-12 21:16:22 2018-03-15 19:46:33   70.5  e     TRUE 
    ##  8 2018-03-13 03:51:50 2018-03-13 08:52:22    5.01 g     TRUE 
    ##  9 2018-03-13 16:09:14 2018-03-14 20:28:32   28.3  l     TRUE 
    ## 10 2018-03-13 13:01:16 2018-03-14 05:21:15   16.3  n     TRUE 
    ## # ... with 92 more rows

-   select(): Select specific columns from the `tibble`

``` r
# pull all start and end times
select(t2, start, end)
```

    ## # A tibble: 1,001 x 2
    ##    start               end                
    ##    <dttm>              <dttm>             
    ##  1 2018-03-13 12:52:29 2018-04-03 13:45:16
    ##  2 2018-03-13 08:48:45 2018-03-13 08:48:46
    ##  3 2018-03-13 12:25:35 2018-04-11 15:27:53
    ##  4 2018-03-13 13:30:33 2018-03-28 03:42:08
    ##  5 2018-03-13 03:50:04 2018-03-14 06:55:43
    ##  6 2018-03-13 12:18:49 2018-04-11 08:16:49
    ##  7 2018-03-13 19:08:21 2018-03-24 09:20:41
    ##  8 2018-03-13 14:10:51 2018-03-21 19:54:57
    ##  9 2018-03-13 04:28:05 2018-04-02 07:16:05
    ## 10 2018-03-13 20:13:53 2018-03-19 08:19:09
    ## # ... with 991 more rows

``` r
# or drop the l column
select(t2, -l)
```

    ## # A tibble: 1,001 x 4
    ##    start               end                 elapsed case 
    ##    <dttm>              <dttm>                <dbl> <lgl>
    ##  1 2018-03-13 12:52:29 2018-04-03 13:45:16   505.  TRUE 
    ##  2 2018-03-13 08:48:45 2018-03-13 08:48:46    24.0 NA   
    ##  3 2018-03-13 12:25:35 2018-04-11 15:27:53   699.  TRUE 
    ##  4 2018-03-13 13:30:33 2018-03-28 03:42:08   350.  TRUE 
    ##  5 2018-03-13 03:50:04 2018-03-14 06:55:43    27.1 TRUE 
    ##  6 2018-03-13 12:18:49 2018-04-11 08:16:49   692.  TRUE 
    ##  7 2018-03-13 19:08:21 2018-03-24 09:20:41   254.  TRUE 
    ##  8 2018-03-13 14:10:51 2018-03-21 19:54:57   198.  TRUE 
    ##  9 2018-03-13 04:28:05 2018-04-02 07:16:05   483.  TRUE 
    ## 10 2018-03-13 20:13:53 2018-03-19 08:19:09   132.  TRUE 
    ## # ... with 991 more rows

### Printing

You can change the defaults of tibble display with options.

``` r
tmp <- options()
options(tibble.print_min = 6)
t2
```

    ## # A tibble: 1,001 x 5
    ##   start               end                 elapsed l     case 
    ##   <dttm>              <dttm>                <dbl> <chr> <lgl>
    ## 1 2018-03-13 12:52:29 2018-04-03 13:45:16   505.  d     TRUE 
    ## 2 2018-03-13 08:48:45 2018-03-13 08:48:46    24.0 f     NA   
    ## 3 2018-03-13 12:25:35 2018-04-11 15:27:53   699.  p     TRUE 
    ## 4 2018-03-13 13:30:33 2018-03-28 03:42:08   350.  f     TRUE 
    ## 5 2018-03-13 03:50:04 2018-03-14 06:55:43    27.1 n     TRUE 
    ## 6 2018-03-13 12:18:49 2018-04-11 08:16:49   692.  q     TRUE 
    ## # ... with 995 more rows

``` r
# reset options
options(tmp)
```

You can also use the `tibble.width = Inf` option to print all columns. There are more options documented at `package?tibble`.

<a name="eeTibbles"></a>Examples and Exercises
----------------------------------------------

For more examples, see line `26`of [Examples.R](https://github.com/ravichas/TidyingData/blob/master/Examples.R).

Practice exercises for this section can be found in [Exercsies.Rmd](https://github.com/ravichas/TidyingData/blob/master/Exercises.md#tibbleEx).

<a name="import"></a>Importing Data
===================================

RStudio has a nice data import utility under File &gt; Import Dataset. This will generate the code to repeat the import (i.e. so you can save it to your script).

![](Images/RS-ImportDataset.png)

If you are comfortable with writing the code directly, the following functions will import data into tibbles:

-   `?read_csv`: import comma separated values data
-   `?read_csv2`: import semicolon separated values data (European version of a csv)
-   `?read_tsv`: import tab delimited data
-   `?read_delim`: import a text file with data (e.g. space delimited)
-   `?read_excel`: import Excel formatted data (either xls or xlsx format)

If you are familiar with R you may recognize that there are data.frame generating counterparts from the utils package (e.g. `read.csv()` and `read.delim()`). Why would we want to use these function from the readr package over the base-R functions?

-   Speed (~ 10x) - this can make a big difference with very large data sets
-   Output from readr is a tibble
-   Base R taps into the OS where it is executed, but `readr` functions are OS independent and hence more consistent across platforms

``` r
# returns a data.frame
read.csv('Data/WHO-2a.csv')
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
require(readr)
# returns a tibble
# also, note the helpful warning that several columns have the same name
read_csv('Data/WHO-2a.csv')
```

    ## Warning: Duplicated column names deduplicated: '2007-2013' =>
    ## '2007-2013_1' [3]

    ## Parsed with column specification:
    ## cols(
    ##   Country = col_character(),
    ##   `2007-2013` = col_double(),
    ##   `2007-2013_1` = col_double()
    ## )

    ## # A tibble: 32 x 3
    ##   Country                          `2007-2013` `2007-2013_1`
    ##   <chr>                                  <dbl>         <dbl>
    ## 1 Bahamas                                15.9           2.20
    ## 2 Bolivia (Plurinational State of)        4.50          3.50
    ## 3 Brazil                                 11.3          NA   
    ## 4 Burkina Faso                            2.90          2.20
    ## 5 Burundi                                 2.80          1.70
    ## 6 China                                   1.40          1.60
    ## # ... with 26 more rows

<a name="skip"></a>Comments/Metadata
------------------------------------

Sometimes, there will be extra metadata at the top of a file, often preceded with '\#'. How do we read a data set that has some metadata (indicated by '\#')? What if the extra lines aren't properly marked with '\#'?

``` r
# we want to skip this first line
readLines("Data/WHO-2.csv")[1:3]
```

    ## [1] "#Country,Median consumer price ratio of selected generic medicines - Private,Median consumer price ratio of selected generic medicines - Public"
    ## [2] "Country,CPR_private,CPR_public"                                                                                                                 
    ## [3] "Bahamas,15.9,2.2"

``` r
# ignore metadata row
read_csv("Data/WHO-2.csv", comment = "#")
```

    ## Parsed with column specification:
    ## cols(
    ##   Country = col_character(),
    ##   CPR_private = col_double(),
    ##   CPR_public = col_double()
    ## )

    ## # A tibble: 32 x 3
    ##   Country                          CPR_private CPR_public
    ##   <chr>                                  <dbl>      <dbl>
    ## 1 Bahamas                                15.9        2.20
    ## 2 Bolivia (Plurinational State of)        4.50       3.50
    ## 3 Brazil                                 11.3       NA   
    ## 4 Burkina Faso                            2.90       2.20
    ## 5 Burundi                                 2.80       1.70
    ## 6 China                                   1.40       1.60
    ## # ... with 26 more rows

``` r
# this results in identical output, but we specify how many lines to skip
read_csv("Data/WHO-2.csv", skip = 1)
```

    ## Parsed with column specification:
    ## cols(
    ##   Country = col_character(),
    ##   CPR_private = col_double(),
    ##   CPR_public = col_double()
    ## )

    ## # A tibble: 32 x 3
    ##   Country                          CPR_private CPR_public
    ##   <chr>                                  <dbl>      <dbl>
    ## 1 Bahamas                                15.9        2.20
    ## 2 Bolivia (Plurinational State of)        4.50       3.50
    ## 3 Brazil                                 11.3       NA   
    ## 4 Burkina Faso                            2.90       2.20
    ## 5 Burundi                                 2.80       1.70
    ## 6 China                                   1.40       1.60
    ## # ... with 26 more rows

<a name="eeImport"></a>Exercises
--------------------------------

Work through the exercises in the Tidyverse section of [Exercises.R](https://raw.githubusercontent.com/ravichas/TidyingData/master/Exercises.R).
