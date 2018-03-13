# Data Tidying Seminar Examples

# Each example we cover is flagged with a comment.

### Index of Examples ###


######################################
# Packages needed for these examples #
######################################

# This is a compelte list of packages you will need for this seminar.
# To help with knowing what packages we are using at different points, we will
# include `require()` satements when a specific package is required. This will not
# go to the effort of loading a package if it has already been loaded.

library(tidyverse) # this loads the following packages:
                   # ggplot2, tibble, tidyr, readr, purrr, dplyr
library(lubridate)


####################
# Tidyverse Basics #
####################

########## tibble Examples ##########
## Hands-on exercise using Wisconsin Breast Cancer dataset

(wdbc <- read_csv("Data/wdbc.data", col_names = FALSE))

# Add names
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


# How many samples do we have in the dataset? 
# How many covariates are in the dataset?
str(wdbc)

# We can look at the Global environment (top right) window to get the information,
# or we can look at the dimensions of wdbc
dim(wdbc)
nrow(wdbc)
ncol(wdbc)


#############
# Date/Time #
#############

########## Comparison of POSIXct and POSIXlt formats ##########

(timext <- Sys.time())
class(timext)
typeof(timext)
cat(timext, "\n")

# convert POSIXct fomratted time into POSIXlt formatted time
(timelt <- as.POSIXlt(timext))
class(timelt)
typeof(timelt)
attributes(timelt)
lapply(timelt, identity)

require(lubridate)
# turn the current system time into a string
# note the default format for this is "%Y-%m-%d %H:%M:%S"
(string_timenow <- now() %>% strftime())  # e.g. "2017-03-07 15:52:03 EST"
class(string_timenow)

# convert string_timenow back into a POSIXlt time
(Posixct_timenow <- strptime(string_timenow,"%Y-%m-%d %H:%M:%S" ))
class(Posixct_timenow)


########## lubridate Examples ##########

require(lubridate)

# by default, these both produce the same result
Sys.time()
now()

# however, now() can be used to get the time in a different timezone
now("GMT")

# the Wall Street Market crash of 1929
crash <- strptime("Oct 29, 1929 9:30 AM", format = "%B %d, %Y %H:%M %p")

# what day of the week was the Wall Street Market crash of 1929?
wday(crash, label = TRUE)

# really the crash started on Monday and continued into Tuesday
# this is the interval over which the crash happened
crash <- interval(crash - days(1),                        # Monday @ 9:30 AM
                  crash + period(hours = 6, minutes = 30))# Tuesday @ 4:00 PM


########## Date arithmetic ##########

require(lubridate)

jan28 <- strptime(c("2016-01-28", "2017-01-28"), format = "%Y-%m-%d")

# we can add a month and then a day is OK
jan28 + months(1) + days(1)

# adding a day then a month can be problematic
jan28 + days(1) + months(1)


########## grep ##########

# our list of IDs
IDS <-	c("NP_004`318.3", "XP_003317181.1", "XP_002798337.1", "XP_848654.2", "NP_001074881.1", "XP_228091.6", "XP_415244.3", "NP_001123792.1", "XP_005161278")

# find all IDs that contain "NP"
(grepids <- grep(pattern = "NP", x = IDS))

IDS[grepids]

# a new set of IDs
MIDS <-	c("NP_004`318.3", "XP_003317181.1", "XP_002798337.1", "XP_848654.2", "np_001074881.1", "XP_228091.6", "XP_415244.3", "NP_001123792.1", "XP_005161278")

# find all IDs that contain "NP"
grepmids <- grep("NP", MIDS)
MIDS[grepmids]

# find all IDs that contain NP (case insensitive)
grep("NP", MIDS, ignore.case = TRUE, value = TRUE)

# this will return TRUE/FALSE values for each string in the vector
grepl("NP", MIDS, ignore.case = TRUE)


########## g/sub ##########

species <- c("Arabidopsis_thaliana", "Bos_taurus", "Caenorhabditis_elegans", "Danio_rerio", 
             "Dictyostelium_discoideum", "Drosophila_melanogaster", "Escherichia_coli",
             "Homo_sapiens", "Mus_musculus", "Mycoplasma_pneumoniae",
             "Oryza_sativa","Plasmodium_falciparum","Pneumocystis_carinii","Rattus_norvegicus",
             "Saccharmomyces_cerevisiae","Schizosaccharomyces_pombe","Takifugu_rubripes","Xenopus_laevis",
             "Zea_mays")

# replace '_' with ' '
sub("_", " ", species)

# add a new species (this has two _ characters)
species <- c(species, "Hepatitis_C_Virus")

# only the first '_' is replaced
sub("_", " ", species)

# both are replaced using gsub()
gsub("_", " ", species)

# search for "sapiens" or "sativa"            (three different outputs)
grep("sapiens|sativa", species)               # index
grep("sapiens|sativa", species, value = TRUE) # values
grepl("sapiens|sativa", species)              # TRUE/FALSE vector

# search for strings starting with D
grep("^D", species)