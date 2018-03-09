Data Tidying: Dates, Time, and Regular Expressions
================
Drs. Sarangan Ravichandran and Randall Johnson

Table of Contents
=================

1.  [Dates and Time](#dateTime)

    1.1 [Base R](#dateTimeR)

    1.2 [lubridate](#dateTimeLub)

    1.3 [Arithmetic](#dateTimeMath)

2.  [Regular Expressions](#regEx)

<a name="dateTime"></a>Dates and Time
=====================================

<a name="dateTimeR"></a>Base R
------------------------------

Dates and times are stored in one of three formats in R:

-   Date - number of days since January 1, 1970
-   POSIXct - number of seconds since January 1, 1970
-   POSIXlt - a list containing information about the time (see Table 1)

|  Position| Name   | Value                                     |
|---------:|:-------|:------------------------------------------|
|         1| sec    | seconds                                   |
|         2| min    | minutes                                   |
|         3| hour   | hours                                     |
|         4| mday   | day of the month (1-31)                   |
|         5| mon    | month of the year (0-11)                  |
|         6| year   | years since 1900                          |
|         7| wday   | day of the week (0: Sunday - 6: Saturday) |
|         8| yday   | day of the year (0-365)                   |
|         9| isdst  | daylight savings (Yes/No)                 |
|        10| zone   | time zone                                 |
|        11| gmtoff | seconds off of GMT                        |

If you are interested, there are some examples in [Examples.R](https://github.com/ravichas/TidyingData/blob/master/Examples.R) comparing the format of these two variables, starting on line `31`.

You can use the `as.date()` function to create a date variable in R, and you can also use it to convert strings into dates. In either case, you will want to be aware of how the text you give to `as.Date()` is formatted. According to the documentation (see `?as.Date`), the default format is "YYYY-MM-DD" or "YYYY/MM/DD". If neither works and you didn't specify a different format, `as.date()` will return `NA`.

To specify formatting, see the values in Table 2. For example, the default formats `as.Date()` expects would be coded as `%Y-%m-%d` or `%Y/%m/%d`. If you have a date, "May 3, 2018", you would need to specify the format as `%B %d, %Y`

| Code | Value                             |
|:-----|:----------------------------------|
| %d   | Day of the month (integer, 01-31) |
| %m   | Month (integer, 01-12)            |
| %b   | Month (abbreviation)              |
| %B   | Month (full name)                 |
| %y   | Year (2 digit)                    |
| %Y   | Year (4 digit)                    |

``` r
as.Date('1920-6-16')
```

    ## [1] "1920-06-16"

``` r
as.Date('2017/03/07')
```

    ## [1] "2017-03-07"

``` r
as.Date("May 3, 2018", format = "%B %d, %Y")
```

    ## [1] "2018-05-03"

``` r
## Get current Date and Time from the system 
Sys.Date() # returns a Date object
```

    ## [1] "2018-03-09"

``` r
Sys.time() # returns a POSIXct object
```

    ## [1] "2018-03-09 14:42:27 EST"

Formatting times is a little more complicated. For this task `strftime()` and `strptime()` are our friends.

-   `strftime()` returns a character string (or character vector of strings) representing the input.
-   `strptime()` returns POSIXlt formatted values represented by the input.

These function both have a default format of `%Y-%m-%d %H:%M:%S` if any element has a time component which is not midnight, and `%Y-%m-%d` otherwise (see `?strptime` for the full list of codes). For example:

``` r
# get the current system time as a string
Sys.time() %>% strftime()
```

    ## [1] "2018-03-09 14:42:27"

``` r
# convert this string to POSIXlt format (assumes local time zone)
strptime("May 3, 2018 1:45 PM", format = "%B %d, %Y %H:%M %p")
```

    ## [1] "2018-05-03 01:45:00 EST"

<a name="dateTimeLub"></a>libridate
-----------------------------------

The [lubridate](https://github.com/tidyverse/lubridate/blob/master/vignettes/lubridate.Rmd) package, which is part of the tidyverse, has some additional functions that will help us work with dates and time.

-   `now()` essentially does the same thing as `Sys.time()` by default, but you can optionally specify a different timezone.
-   `second()`, `minute()`, `hour()`, `day()`, `year()`, ... allow you to extract or set (change) the specified part of a POSIXlt formatted variable.
-   `seconds()`, `minutes()`, `hours()`, `days()`, `years()`, ... allow you to specify a period of time (e.g. `days(5)` is 5 days).

See line `56`of [Examples.R](https://github.com/ravichas/TidyingData/blob/master/Examples.R) for some examples using the *lubridate* package.

Note: there seems to be a bug with R's handling of the default time zone settings on some systems (as of early 2018). If you happen to run into this error,

    Error in (function (dt, year, month, yday, mday, wday, hour, minute, second,  : 
      Invalid timezone of input vector: ""

this bit of code will set things straight (or something similar, e.g. EDT or GMT):

``` r
Sys.setenv(TZ="EST")
```

<a name="dateTimeMath"></a>Arithmetic
-------------------------------------

> "If anyone drove a time machine, they would crash" - Hadley Wickham, author of the tidyverse

As Hadley Wickham points out [here](https://github.com/tidyverse/lubridate/blob/master/vignettes/lubridate.Rmd#if-anyone-drove-a-time-machine-they-would-crash), arithmetic with dates isn't as straight forward as it could be. Take the following operation for example: `January 31 + one month`. There are at least three possible answers:

-   February 31 (doesn't exist)
-   March 4 (31 days after January 31st)
-   February 28 (or the 29th if it is a leap year)

Ug! To avoid abiguity, lubridate implements addition in a very specific way.

-   By default, adding time, increments the specified slot approriately in the data structure. For example, when you add a month, you simply increment the month slot by 1.
    -   If you add a month to December 23, the month slot goes back to 1 and the year is incrmented by 1.
    -   If you add a month to January 31, you get `NA`, because February 31 doesn't exist. If you want one of the other two options above, you need to craft your statement a little more carefully (e.g. by adding `days(30)` instead of `months(1)`).
-   Alternately, some shorcut functions allow the addition of a fixed period of time.
    -   For example, `dyears(1)` is 365 days, even on a leap year, while `years(1)` increments the years slot by 1 year, without respect to leap years.

Excercises
----------

Practice exercises for this section can be found in [Exercsies.Rmd](https://github.com/ravichas/TidyingData/blob/master/Exercises.md#timeEx).

<a name="regEx"></a>Regular Expressions
=======================================

### What is a Regex?

-   Was originally developed for PERL
-   Regular Expressions help us identify patterns in text.
-   Cross-platform compatible
-   Speed up calculations

### How do they work?

### Example for using Grep

``` r
IDS <-  c("NP_004`318.3", "XP_003317181.1", "XP_002798337.1", "XP_848654.2", "NP_001074881.1", "XP_228091.6", "XP_415244.3", "NP_001123792.1", "XP_005161278")

grepids <- grep(pattern = "NP", x = IDS)

IDS[grepids]
```

    ## [1] "NP_004`318.3"   "NP_001074881.1" "NP_001123792.1"

``` r
MIDS <- c("NP_004`318.3", "XP_003317181.1", "XP_002798337.1", "XP_848654.2", "np_001074881.1", "XP_228091.6", "XP_415244.3", "NP_001123792.1", "XP_005161278")


grepmids <- grep("NP", MIDS, ignore.case = FALSE)
IDS[grepmids]
```

    ## [1] "NP_004`318.3"   "NP_001123792.1"

``` r
grepmids <- grep("NP", MIDS, ignore.case = TRUE)
IDS[grepmids]
```

    ## [1] "NP_004`318.3"   "NP_001074881.1" "NP_001123792.1"

### What is grepl?

``` r
grepl("NP", MIDS, ignore.case = TRUE) 
```

    ## [1]  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE

### What are sub and gsub functions?

``` r
species <- c("Arabidopsis_thaliana", "Bos_taurus", "Caenorhabditis_elegans", "Danio_rerio", 
             "Dictyostelium_discoideum", "Drosophila_melanogaster", "Escherichia_coli",
             "Homo_sapiens", "Mus_musculus", "Mycoplasma_pneumoniae",
             "Oryza_sativa","Plasmodium_falciparum","Pneumocystis_carinii","Rattus_norvegicus",
             "Saccharmomyces_cerevisiae","Schizosaccharomyces_pombe","Takifugu_rubripes","Xenopus_laevis",
             "Zea_mays")
species
```

    ##  [1] "Arabidopsis_thaliana"      "Bos_taurus"               
    ##  [3] "Caenorhabditis_elegans"    "Danio_rerio"              
    ##  [5] "Dictyostelium_discoideum"  "Drosophila_melanogaster"  
    ##  [7] "Escherichia_coli"          "Homo_sapiens"             
    ##  [9] "Mus_musculus"              "Mycoplasma_pneumoniae"    
    ## [11] "Oryza_sativa"              "Plasmodium_falciparum"    
    ## [13] "Pneumocystis_carinii"      "Rattus_norvegicus"        
    ## [15] "Saccharmomyces_cerevisiae" "Schizosaccharomyces_pombe"
    ## [17] "Takifugu_rubripes"         "Xenopus_laevis"           
    ## [19] "Zea_mays"

``` r
sub("_", " ", species)
```

    ##  [1] "Arabidopsis thaliana"      "Bos taurus"               
    ##  [3] "Caenorhabditis elegans"    "Danio rerio"              
    ##  [5] "Dictyostelium discoideum"  "Drosophila melanogaster"  
    ##  [7] "Escherichia coli"          "Homo sapiens"             
    ##  [9] "Mus musculus"              "Mycoplasma pneumoniae"    
    ## [11] "Oryza sativa"              "Plasmodium falciparum"    
    ## [13] "Pneumocystis carinii"      "Rattus norvegicus"        
    ## [15] "Saccharmomyces cerevisiae" "Schizosaccharomyces pombe"
    ## [17] "Takifugu rubripes"         "Xenopus laevis"           
    ## [19] "Zea mays"

Let us look at what happens when we add a new species.
------------------------------------------------------

``` r
mspecies <- c(species, "Hepatitis_C_Virus")
mspecies
```

    ##  [1] "Arabidopsis_thaliana"      "Bos_taurus"               
    ##  [3] "Caenorhabditis_elegans"    "Danio_rerio"              
    ##  [5] "Dictyostelium_discoideum"  "Drosophila_melanogaster"  
    ##  [7] "Escherichia_coli"          "Homo_sapiens"             
    ##  [9] "Mus_musculus"              "Mycoplasma_pneumoniae"    
    ## [11] "Oryza_sativa"              "Plasmodium_falciparum"    
    ## [13] "Pneumocystis_carinii"      "Rattus_norvegicus"        
    ## [15] "Saccharmomyces_cerevisiae" "Schizosaccharomyces_pombe"
    ## [17] "Takifugu_rubripes"         "Xenopus_laevis"           
    ## [19] "Zea_mays"                  "Hepatitis_C_Virus"

``` r
grep(pattern="g.cus", mspecies)
```

    ## [1] 14

Let us use the substitute, sub, command on the modified string?

``` r
sub("_", " ", mspecies)
```

    ##  [1] "Arabidopsis thaliana"      "Bos taurus"               
    ##  [3] "Caenorhabditis elegans"    "Danio rerio"              
    ##  [5] "Dictyostelium discoideum"  "Drosophila melanogaster"  
    ##  [7] "Escherichia coli"          "Homo sapiens"             
    ##  [9] "Mus musculus"              "Mycoplasma pneumoniae"    
    ## [11] "Oryza sativa"              "Plasmodium falciparum"    
    ## [13] "Pneumocystis carinii"      "Rattus norvegicus"        
    ## [15] "Saccharmomyces cerevisiae" "Schizosaccharomyces pombe"
    ## [17] "Takifugu rubripes"         "Xenopus laevis"           
    ## [19] "Zea mays"                  "Hepatitis C_Virus"

What happened?

sub will only modify the first occurrence of the pattern. To modify all occurrences in a string, use gsub

``` r
gsub("_", " ", mspecies)
```

    ##  [1] "Arabidopsis thaliana"      "Bos taurus"               
    ##  [3] "Caenorhabditis elegans"    "Danio rerio"              
    ##  [5] "Dictyostelium discoideum"  "Drosophila melanogaster"  
    ##  [7] "Escherichia coli"          "Homo sapiens"             
    ##  [9] "Mus musculus"              "Mycoplasma pneumoniae"    
    ## [11] "Oryza sativa"              "Plasmodium falciparum"    
    ## [13] "Pneumocystis carinii"      "Rattus norvegicus"        
    ## [15] "Saccharmomyces cerevisiae" "Schizosaccharomyces pombe"
    ## [17] "Takifugu rubripes"         "Xenopus laevis"           
    ## [19] "Zea mays"                  "Hepatitis C Virus"

### Can we look for a word in each strings?

-regexpr returns the position in the string of the pattern. It will also return the length of the pattern matched.

``` r
regexpr("sa", mspecies)
```

    ##  [1] -1 -1 -1 -1 -1 -1 -1  6 -1 -1  7 -1 -1 -1 -1  7 -1 -1 -1 -1
    ## attr(,"match.length")
    ##  [1] -1 -1 -1 -1 -1 -1 -1  2 -1 -1  2 -1 -1 -1 -1  2 -1 -1 -1 -1
    ## attr(,"useBytes")
    ## [1] TRUE

### <span style="color:green">RegEx Exercise-1</span>

-   Find out what regexec and gregexpr

You can combine regex keywords
------------------------------

``` r
grep("sapiens|sativa", mspecies)
```

    ## [1]  8 11

``` r
mylist <- c("b*taurus", "C*elegans", "D*rerio", 
             "H*sapiens", "M*musculus", "R*norvegicus")

grep("H*sapiens", mspecies, ignore.case = TRUE)
```

    ## [1] 8

Note that `\\` is used for escaping a character
