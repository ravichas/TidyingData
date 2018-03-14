# check that your system is set up for the Data Tidying hands-on seminar

if(!require(tidyverse))
    stop("The tidyverse package is not installed properly.")

## didn't end up using this.
## if(!require(biobroom))
##    stop("The biobroom package is not installed properly.")

it_works <- try({
dat <- data_frame(x = rnorm(100),
                  y = x + rnorm(100))

library(broom)
model <- lm(y ~ x, data = dat)
model_output <- tidy(model)
})

if(class(it_works) == 'try-error')
    stop("something is wrong - ", it_works)

print("Your machine is ready for the Data Tidying seminar.")
