<a name="tibbleEx"></a>Tibble Exercises
---------------------------------------

### Create a new tibble

Create a new tibble called `tbl1` with 5 observations and the following
variables:

-   name
-   age
-   height
-   weight
-   smoker (TRUE or FALSE)
-   Male (TRUE or FALSE)

Once you have created `tbl1`, add a new dummary variable, `agecat`, that
categorizes age by decade (i.e. `agecat = 0` when `age < 10`,
`agecat = 1` when `10 <= age < 20`, ...)

    set.seed(923874)
    tbl1 <- tibble(name = c("Sam","Tom","John","Stacy","Naomi"),
                   age = sample(1:100,5),
                   height = sample(150:190,5),
                   weight = sample(120:220,5),
                   smoker = sample(c("TRUE","FALSE"),5, replace = TRUE),
                   Male = c("TRUE","TRUE","TRUE","FALSE","FALSE"))

    tbl1 <- mutate(tbl1,
                   agecat = age %/% 10)
    #              agecat = floor(age / 10)) # another possible solution

### Conversion of a data.frame to a data\_frame

Convert the iris data set to a tibble.

    data(iris)
    str(iris)

    ## 'data.frame':    150 obs. of  5 variables:
    ##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
    ##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
    ##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
    ##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
    ##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...

    iris_tibble <- as_tibble(iris)

How can you verify that your modified `iris` data set is formatted as a
tibble?

### NEISS data

The datset that we will be using for this section comes from the  
National Electronic Injury Surveillance System (NEISS)
<https://www.cpsc.gov/research--statistics/neiss-injury-data> Here is a
short description of the data file from the NEISS.

*"Each record (case) is separated by a carriage return/line feed, and
the fields (parameters and narrative) are separated by a tab character,
which you can specify as the delimiter when importing into a spreadsheet
or database."*

Read the data file, **nss15.tsv** file from the sub-folder/directory,
**Data** and call the data as **nss15** variable.

**Hint:** You could use the File --&gt; Import --&gt; Data DataSet
option to read the file. The data is in a tab-separated format.

**Hint:** Watch out for the data type choices that are suggested to you
and be sure to select the appropriate ones

**Hint:** Please watch out for any warnings or issues while R/Rstudio is
reading the files. If you spot any errors, think of how to fix it. After
fixing the problems (if any), go back and read the file.

    ### Setup
    # this will create look-up variables so you can make better sense of the codes in the data set
    source('Data/NEISSlabels.R')

    # for example, if you want to know what body parts these codes indicate...
    x <- c(30, 30, 77, 35)
    get_label(x, body_part_lab)

    ## [1] "SHOULDER" "SHOULDER" "EYEBALL"  "KNEE"

    ### Import data code goes here
    require(readr)
    nss15 <- read_delim("Data/nss15.tsv", "\t", escape_double = FALSE, trim_ws = TRUE,
                        col_types = cols(trmt_date = col_date(format = "%m/%d/%Y")))

    ## Warning in rbind(names(probs), probs_f): number of columns of result is not
    ## a multiple of vector length (arg 1)

    ## Warning: 10 parsing failures.
    ## row # A tibble: 5 x 5 col      row col   expected   actual     file             expected    <int> <chr> <chr>      <chr>      <chr>            actual 1  10821 <NA>  19 columns 20 columns 'Data/nss15.tsv' file 2  48622 <NA>  19 columns 20 columns 'Data/nss15.tsv' row 3  62533 <NA>  19 columns 20 columns 'Data/nss15.tsv' col 4 103738 <NA>  19 columns 20 columns 'Data/nss15.tsv' expected 5 135494 <NA>  19 columns 20 columns 'Data/nss15.tsv'
    ## ... ................. ... ..................................................... ........ ..................................................... ...... ..................................................... .... ..................................................... ... ..................................................... ... ..................................................... ........ .....................................................
    ## See problems(...) for more details.

    ### mutate code converting codes into human readable labels goes here
    require(dplyr)
    nss15 <- mutate(nss15,
                    sex = get_label(sex, gender_lab),
                    race = get_label(race, race_lab),
                    diag = get_label(diag, diag_lab),
                    body_part = get_label(body_part, body_part_lab),
                    disposition = get_label(disposition, disposition_lab),
                    location = get_label(location, location_lab),
                    fmv = get_label(fmv, fmv_lab),
                    prod1 = get_label(prod1, product_lab),
                    prod2 = get_label(prod2, product_lab))

Answer the following questions.

-   How many cases are reported in this dataset?
-   How many covariates this dataset has?
-   Access CPSC Case \# 150620565 and report the following things:
-   What is the age of the patient?
-   What is the Race, weight, Stratum, Sex, Race and Diagnosis
-   How many are more than 100 years old?  
-   From the reported cases, get the CPSC case number and age for the
    20th entry.

<!-- -->

    ### further exploration to answer questions goes here

    # How many cases?
    nrow(nss15)

    ## [1] 357737

    dim(nss15)[1] # same answer

    ## [1] 357737

    # How many covariates?
    ncol(nss15)

    ## [1] 19

    dim(nss15)[2]        # same answer

    ## [1] 19

    length(names(nss15)) # same answer

    ## [1] 19

    # CPSC Case # 150620565
    filter(nss15, `CPSC Case #` == 150620565) %>%
        select(`CPSC Case #`, age, race, stratum, sex, diag)

    ## # A tibble: 1 x 6
    ##   `CPSC Case #`   age race  stratum sex    diag           
    ##           <int> <int> <chr> <chr>   <chr>  <chr>          
    ## 1     150620565   219 WHITE C       FEMALE INTERNAL INJURY

    # How many over 100 years?
    filter(nss15, age > 100) %>%
        nrow()

    ## [1] 20664

    summary(nss15$age)

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##    0.00   12.00   28.00   43.59   58.00  223.00

This seems like a lot of people, and I'm sure that no on was actually
223 years old. Upon further inspection of the documentation, any age
over 200 is `200 + age in months`.

    # fix age and recalculate how many over 100 years.
    nss15 <- mutate(nss15,
                    age = ifelse(age >= 200, (age - 200) / 12, age))

    filter(nss15, age > 100) %>%
        nrow()

    ## [1] 108

    # CPSC case number and age for the 20th entry
    nss15[20,c(1,6)]

    ## # A tibble: 1 x 2
    ##   `CPSC Case #`   age
    ##           <int> <dbl>
    ## 1     150970927 0.333

<a name="timeEx"></a>Date/Time Exercises
----------------------------------------

Answer the following questions using the NEISS data set that you
imported above.

-   Report the number of cases for the month of May?
    -   Tell us how many cases were reported for May 13 - May 16, 2015?
    -   Use this information to answer the following questions.
-   How many were children ( &lt; 5 years)?
-   provide the proportion of male/female?
-   What was the race distribution?

<!-- -->

    # How many cases in May?
    require(lubridate)
    filter(nss15, month(trmt_date) == 5) %>%
        nrow()

    ## [1] 34067

    ### Cases between May 13 and May 16 ###
    nss15_sub <- filter(nss15, trmt_date >= as.Date("2015-05-13") &
                               trmt_date <= as.Date("2015-05-16"))

    # How many cases in this date range?
    nrow(nss15_sub)

    ## [1] 4297

    # How many children < 5 years?
    filter(nss15_sub, age < 5) %>%
        nrow()

    ## [1] 555

    # proportion male/female
    with(nss15_sub, sum(sex == 'MALE') / length(sex))

    ## [1] 0.5629509

    # race distribution
    table(nss15_sub$race)

    ## 
    ##    American Indian/Alaska Native                            ASIAN 
    ##                               10                               48 
    ##                            BLACK Native Hawaiian/Pacific Islander 
    ##                              571                                7 
    ##                            OTHER                          UNKNOWN 
    ##                              236                             1761 
    ##                            WHITE 
    ##                             1664

    table(nss15_sub$race_other) # nice misspellings/inconsistent reporting here

    ## 
    ##     BIRACIAL     DECLINED         HISP     HISPANIC        HMONG 
    ##            1            1           19          165            1 
    ##        MULTI MULTI-RACIAL  MULTIRACIAL           NS       SOMALI 
    ##            1           24            1            8            1 
    ##      UNKNOWN       UNNOWN 
    ##           27            1

<a name="regEx"></a>Regular Expressions Exercises
-------------------------------------------------

-   `regexpr()` returns the position in the string of the pattern. It
    will also return the length of the pattern matched. Use `regexpr()`
    to locate all species names with the pattern 'sa'.
-   Identify all species that end with the letter 's'

<!-- -->

    species <- c("Arabidopsis_thaliana", "Bos_taurus", "Caenorhabditis_elegans", "Danio_rerio", 
                 "Dictyostelium_discoideum", "Drosophila_melanogaster", "Escherichia_coli",
                 "Homo_sapiens", "Mus_musculus", "Mycoplasma_pneumoniae",
                 "Oryza_sativa","Plasmodium_falciparum","Pneumocystis_carinii","Rattus_norvegicus",
                 "Saccharmomyces_cerevisiae","Schizosaccharomyces_pombe","Takifugu_rubripes","Xenopus_laevis",
                 "Zea_mays", "Hepatitis_C_Virus")

    # All species names with the pattern 'sa'
    grep('sa', species, value = TRUE)

    ## [1] "Homo_sapiens"              "Oryza_sativa"             
    ## [3] "Schizosaccharomyces_pombe"

    regexpr('sa', species) # e.g.  1234567...

    ##  [1] -1 -1 -1 -1 -1 -1 -1  6 -1 -1  7 -1 -1 -1 -1  7 -1 -1 -1 -1
    ## attr(,"match.length")
    ##  [1] -1 -1 -1 -1 -1 -1 -1  2 -1 -1  2 -1 -1 -1 -1  2 -1 -1 -1 -1
    ## attr(,"useBytes")
    ## [1] TRUE

                           # match -----**-----
                           #       Homo_sapiens

    # all species ending with 's'
    grep('s$', species)

    ## [1]  2  3  8  9 14 17 18 19 20

-   Find out what `regexec()` and `gregexpr()` do. How are they
    different from the other regular expression functions we have
    covered?
