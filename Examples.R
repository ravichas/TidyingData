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


###################
# R/RStudio Intro #
###################


####################
# Tidyverse Basics #
####################

########## tibble Examples ##########
## Hands-on exercise using Wisconsin Breast Cancer dataset

Now, let us read a slightly complicated Breast Cancer dataset. First let us use
the import data set drop-down option 

![](Images/RS-ImportDataset.png)
![](Images/RS-ImportDataset1.png)
```{r readdata}
#wdbc <- read_csv("C:/Users/Ravi/Desktop/BTEP/Data/wdbc.data", col_names = FALSE)

wdbc <- read_csv("Data/wdbc.data", col_names = FALSE)
#wdbctry2 <- read_csv("C:/Users/Ravi/Desktop/BTEP/Data/wdbc.data", header = FALSE)
names(wdbc)
```

Let us add column names

```{r AssignColnams}
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
    
    
    ```{r}
nrow(wdbc)
```
How many covariates are in the dataset? 
    We can look at the Global environment (top right) window to get the information
We can also find that out by typing the following command:
    ```{r}
ncol(wdbc)
```


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

