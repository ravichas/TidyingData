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
    codes <- c(30, 30, 77, 35)
    get_label(codes, body_part)

    ## [1] "SHOULDER" "SHOULDER" "EYEBALL"  "KNEE"

    ### Import data code goes here


    ### mutate code converting codes into human readable labels goes here


    ### further exploration to answer questions goes here

Answer the following questions.

-   How many cases are reported in this dataset?
-   How many covariates this dataset has?
-   Access CPSC Case \# 150620565 and report the following things:
-   What is the age of the patient?
-   What is the Race, weight, Stratum, Sex, Race and Diagnosis
-   How many are more than 100 years old?  
-   How many cases were taken to **Children's Hospital**?
-   From the reported cases, get the CPSC case number and age for the
    20th entry.

<a name="timeEx"></a>Date/Time Exercises
----------------------------------------

Answer the following questions using the NEISS data set that you
imported above.

-   Report the number of cases for the month of May? Tell us how many
    cases were reported for May 13 - May 16, 2015? Use this information
    to answer the following questions.
-   What hospitals were the cases went to (provide a table)?
-   How many were children ( &lt; 5 years)?
-   provide the proportion of male/female?
-   What was the race distribution?

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

    # your regexpr code goes here

-   Find out what `regexec()` and `gregexpr()` do. How are they
    different from the other regular expression functions we have
    covered?
