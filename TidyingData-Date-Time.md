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

The function
<pre> <code> as.Date </code> </pre>
expects the date to be in the - separated format. If it is not, then we should use the following format

``` r
as.Date('03/07/2017', format='%m/%d/%Y')
```

    ## [1] "2017-03-07"

``` r
as.Date('March 07, 2017', format='%B %d, %Y')
```

    ## [1] "2017-03-07"

Let us look to see how R stores the data internally. Two different datatypes that deal with Time and Date variables:

POSIXct
-------

Will provide you the number of seconds that has been elapsed since January 1, 1970.

Negative numebrs indicate seconds before this time.

POSIXlt
-------

-   Type of vector

``` r
Position <- 1:9
Value <- c("seconds","minutes","hours","day of the month (1-31)", "month of the year (0-11)", 
           "years since 1900", "day of the week (0: Sunday - 6: Saturday)", "Day of the year (0-365)",
           "Daylight savings indicator (Positive/Negative: Yes/No")
library(knitr)
tibble2 <- tibble(Position, Value)
kable(tibble2)
```

|  Position| Value                                                 |
|---------:|:------------------------------------------------------|
|         1| seconds                                               |
|         2| minutes                                               |
|         3| hours                                                 |
|         4| day of the month (1-31)                               |
|         5| month of the year (0-11)                              |
|         6| years since 1900                                      |
|         7| day of the week (0: Sunday - 6: Saturday)             |
|         8| Day of the year (0-365)                               |
|         9| Daylight savings indicator (Positive/Negative: Yes/No |

Let us see how we can use these two data types:

``` r
(timext <- Sys.time())
```

    ## [1] "2017-03-07 16:02:47 EST"

``` r
class(timext)
```

    ## [1] "POSIXct" "POSIXt"

``` r
typeof(timext)
```

    ## [1] "double"

``` r
cat(timext, "\n")
```

    ## 1488920567

``` r
(timelt <- as.POSIXlt(timext) )
```

    ## [1] "2017-03-07 16:02:47 EST"

``` r
typeof(timelt)
```

    ## [1] "list"

``` r
names(timelt)
```

    ## NULL

``` r
lapply(timelt, function(x) print(x))
```

    ## [1] 47.37043
    ## [1] 2
    ## [1] 16
    ## [1] 7
    ## [1] 2
    ## [1] 117
    ## [1] 2
    ## [1] 65
    ## [1] 0
    ## [1] "EST"
    ## [1] -18000

    ## $sec
    ## [1] 47.37043
    ## 
    ## $min
    ## [1] 2
    ## 
    ## $hour
    ## [1] 16
    ## 
    ## $mday
    ## [1] 7
    ## 
    ## $mon
    ## [1] 2
    ## 
    ## $year
    ## [1] 117
    ## 
    ## $wday
    ## [1] 2
    ## 
    ## $yday
    ## [1] 65
    ## 
    ## $isdst
    ## [1] 0
    ## 
    ## $zone
    ## [1] "EST"
    ## 
    ## $gmtoff
    ## [1] -18000

\#\# How can we use the time?

``` r
 timenow <- Sys.time()
timenow
```

    ## [1] "2017-03-07 16:02:47 EST"

``` r
timenow - 30 # 30 seconds earlier 
```

    ## [1] "2017-03-07 16:02:17 EST"

Be careful with time data that are used for numerical calculations.

How to store Time in different formats and use it at a later time or using a differnt software?
===============================================================================================

Two commands that can help us accomplish this, strftime and strptime.

strftime: converts a time data and convert it to a string strptime: converts a sting and convert it to Date/time format suitable for R calculations

``` r
string_timenow <- strftime(timenow, "%Y-%m-%d %H:%M:%S")  #"2017-03-07 15:52:03 EST"
string_timenow
```

    ## [1] "2017-03-07 16:02:47"

``` r
class(string_timenow)
```

    ## [1] "character"

``` r
class(timenow)
```

    ## [1] "POSIXct" "POSIXt"

``` r
typeof(string_timenow)
```

    ## [1] "character"

``` r
(Posixct_timenow <- strptime(string_timenow,"%Y-%m-%d %H:%M:%S" ))
```

    ## [1] "2017-03-07 16:02:47 EST"

``` r
class(Posixct_timenow)
```

    ## [1] "POSIXlt" "POSIXt"

\#\# Reference <https://www.stat.berkeley.edu/classes/s133/dates.html>

<http://www.cyclismo.org/tutorial/R/time.html>
