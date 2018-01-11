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

### Date & Times in R

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

    ## [1] "2017-04-05"

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

### POSIXct

Will provide you the number of seconds that has been elapsed since January 1, 1970.

Negative numebrs indicate seconds before this time.

### POSIXlt

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

    ## [1] "2017-04-05 15:20:30 EDT"

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

    ## 1491420031

``` r
(timelt <- as.POSIXlt(timext) )
```

    ## [1] "2017-04-05 15:20:30 EDT"

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

    ## [1] 30.51156
    ## [1] 20
    ## [1] 15
    ## [1] 5
    ## [1] 3
    ## [1] 117
    ## [1] 3
    ## [1] 94
    ## [1] 1
    ## [1] "EDT"
    ## [1] -14400

    ## $sec
    ## [1] 30.51156
    ## 
    ## $min
    ## [1] 20
    ## 
    ## $hour
    ## [1] 15
    ## 
    ## $mday
    ## [1] 5
    ## 
    ## $mon
    ## [1] 3
    ## 
    ## $year
    ## [1] 117
    ## 
    ## $wday
    ## [1] 3
    ## 
    ## $yday
    ## [1] 94
    ## 
    ## $isdst
    ## [1] 1
    ## 
    ## $zone
    ## [1] "EDT"
    ## 
    ## $gmtoff
    ## [1] -14400

### How can we use the time?

``` r
 timenow <- Sys.time()
timenow
```

    ## [1] "2017-04-05 15:20:30 EDT"

``` r
timenow - 30 # 30 seconds earlier 
```

    ## [1] "2017-04-05 15:20:00 EDT"

Be careful with time data that are used for numerical calculations.

### How to store Time in different formats and use it at a later time or using a differnt software?

Two commands that can help us accomplish this, strftime and strptime.

strftime: converts a time data and convert it to a string strptime: converts a sting and convert it to Date/time format suitable for R calculations

``` r
string_timenow <- strftime(timenow, "%Y-%m-%d %H:%M:%S")  #"2017-03-07 15:52:03 EST"
string_timenow
```

    ## [1] "2017-04-05 15:20:30"

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

    ## [1] "2017-04-05 15:20:30 EDT"

``` r
class(Posixct_timenow)
```

    ## [1] "POSIXlt" "POSIXt"

### <span style="color:green">Final R exercise that use Time variable</span>

The datset that we will be using for this section comes from the
National Electronic Injury Surveillance System (NEISS) <https://www.cpsc.gov/research--statistics/neiss-injury-data> Here is a short description of the data file from the NEISS.

*"Each record (case) is separated by a carriage return/line feed, and the fields (parameters and narrative) are separated by a tab character, which you can specify as the delimiter when importing into a spreadsheet or database."*

Before you read in the data, please take a look at the following two files: **NEISS\_SAS\_formats.txt** and **NEISS\_SAS\_variance.txt** These two files will act as the codebook for the data.

Read the data file, **nss15.tsv** file from the sub-folder/directory, **Data** and call the data as **nss15** variable.

**Hint:** Use the File --&gt; Import --&gt; Data DataSet option to read the file. To remind the data is in a tab-separated format.

**Hint:** Watch out for the Data Type choices that are suggested to you and choose the appropriate ones

**Hint:** Please watch out for any warnings or issues while R/Rstudio is reading the files. If you spot any errors, think of how to fix it. After fixing the problems (if any), go back and read the file.

Answer the following questions.

-   Report the number of cases for the month of May? Tell us how many cases were reported for May 13 - May 16, 2015? Use this information to answer the following questions.
-   What hospitals were the cases went to (provide a table)?
-   How many were children ( &lt; 5 years)?
-   provide the proportion of male/female?
-   What was the race distribution?

### What is a Regex?

-   Was originally developed for PERL
-   Regular Expressions help us identify patterns in text.
-   Cross-platform compatible
-   Speed up calculations

### How do they work?

### Example 1

``` r
x <- c("BCR_613", "")
```

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

sub will only modify the first occurance of the pattern. To modify all occurances in a string, use gsub

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

Note that <code>\\</code> is used for escapting a character
