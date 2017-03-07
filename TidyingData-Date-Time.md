BTEP-DateTime
================
Drs. Sarangan Ravichandran and Randall Johnson
February 26, 2017

Let us load the libraries

``` r
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

Date & Times in R
-----------------

Dates and Times are very important. Routinely used in expression (gene) data

``` r
D1 <- as.Date('1920-6-16')
class(D1)
```

    ## [1] "Date"

``` r
D2 <- as.Date('2017/03/07')
class(D2)
```

    ## [1] "Date"

``` r
## Current Date from System 
Sys.Date()
```

    ## [1] "2017-03-07"

If you use <cod> ?as.date </code>, you will see the formats that the function takes.

``` r
Code <- c("%d", "%m","%b","%B","%y","%Y")
Value <- c("Day of the month (decimal numeber)", "Month(decimal number)", "Month (abbreviation)",
           "Month(full name)", "Year (2 digit)", "Year (4 digit)")
library(knitr)
tibble1 <- tibble(Code, Value)
kable(tibble1)
```

| Code | Value                              |
|:-----|:-----------------------------------|
| %d   | Day of the month (decimal numeber) |
| %m   | Month(decimal number)              |
| %b   | Month (abbreviation)               |
| %B   | Month(full name)                   |
| %y   | Year (2 digit)                     |
| %Y   | Year (4 digit)                     |
