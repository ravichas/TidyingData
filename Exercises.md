<a name="timeEx"></a>Date/Time Exercises
----------------------------------------

The data set that we will be using for this section comes from the  
National Electronic Injury Surveillance System (NEISS)
<https://www.cpsc.gov/research--statistics/neiss-injury-data> Here is a
short description of the data file from the NEISS.

*"Each record (case) is separated by a carriage return/line feed, and
the fields (parameters and narrative) are separated by a tab character,
which you can specify as the delimiter when importing into a spreadsheet
or database."*

Before you read in the data, please source the following file:
**Data/NEISSlabels.R** This file will provide human readable labels for
the codes in the nss15 data set. You may also find the `get_label()`
function in this file useful. For example, if you want to get body part
codes for `c(0, 33, 37, 33)`, you could do it like so:

    source('Data/NEISSlabels.R')
    # the hard/ugly way
    sapply(c(0, 33, 37, 33), function(x) which(body_part == x)) %>%
        names()

    ## [1] "INTERNAL"  "LOWER ARM" "ANKLE"     "LOWER ARM"

    # the easy way
    get_label(c(0, 33, 37, 33), body_part)

    ## [1] "INTERNAL"  "LOWER ARM" "ANKLE"     "LOWER ARM"

Read the data file, **nss15.tsv** file from the sub-folder/directory,
**Data** and call the data as **nss15** variable.

**Hint:** Use the File --&gt; Import --&gt; Data DataSet option to read
the file. To remind the data is in a tab-separated format.

**Hint:** Watch out for the Data Type choices that are suggested to you
and choose the appropriate ones

**Hint:** Please watch out for any warnings or issues while R/RStudio is
reading the files. If you spot any errors, think of how to fix it. After
fixing the problems (if any), go back and read the file.

Answer the following questions.

-   Report the number of cases for the month of May? Tell us how many
    cases were reported for May 13 - May 16, 2015? Use this information
    to answer the following questions.
-   What hospitals were the cases went to (provide a table)?
-   How many were children ( &lt; 5 years)?
-   provide the proportion of male/female?
-   What was the race distribution?
