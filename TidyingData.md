TidyingData
========================================================
author: 
date: 
autosize: true
font-family: 'Helvetica'

Loading libraries
========================================================



Vectors
========================================================

Two Types

- Atomic: six types: log, numeric (int, dbl), char,cplx
- Lists: (aka recurcive vec)
- 

Vector
========================================================

- Atomic: six types: log, numeric (int, dbl), char,cplx
- Lists: (aka recurcive vec)

Vector properties
========================================================


```r
typeof(letters) # [1] "character"
```

[1] "character"

```r
typeof(11:20) # [1] "integer"
```

[1] "integer"

```r
x <- list(LETTERS[1], 'b', 1:10)
x
```

[[1]]
[1] "A"

[[2]]
[1] "b"

[[3]]
 [1]  1  2  3  4  5  6  7  8  9 10

```r
length(x)
```

[1] 3

Vector properties
========================================================

* Contain metadata using attributes
* Attributes create augmented vectors which provide additional behavior
* Augemnted vectors (4 types)
  + Factors: under-the-hood are integer vectors
  + Dates/date-times: top of numeric vectors
  + DF and Tibbles are built on top of lists
 
 Logical 
========================================================


```r
10 > 7 # 1] TRUE
```

[1] TRUE

```r
# Three different types, T, F and NA 
c(T,T,F,NA) #[1]  TRUE  TRUE FALSE    NA
```

[1]  TRUE  TRUE FALSE    NA

Numeric (Integer and Double Vectors)
========================================================


```r
# Dboules/floating-point numbers are approximations
x <- sqrt(2)^2
x
```

[1] 2

```r
x - 2 #[1] 4.440892e-16
```

[1] 4.440892e-16

```r
# How can we compare two numeric vectors? 
# == operator is not reliable
# use dplyr::near function which includes tolerance

sqrt(2) ^ 2 == 2
```

[1] FALSE

```r
near(sqrt(2) ^ 2, 2)
```

[1] TRUE

Numeric (Integer and Double Vectors)
========================================================

```r
# In R numbers are created as doubles by default
typeof(1) # [1] "double"
```

[1] "double"

```r
# to create an integer, do this
typeof(1L) # [1] "integer"
```

[1] "integer"

```r
# Three different types, T, F and NA 
c(T,T,F,NA) #[1]  TRUE  TRUE FALSE NA
```

[1]  TRUE  TRUE FALSE    NA

Slide With Plot
========================================================

![plot of chunk unnamed-chunk-6](TidyingData-figure/unnamed-chunk-6-1.png)

Next slide
=======================================================

The Arithmetric mean is equal to $\frac{1}{n} \sum_{i=1}^{n} x_{i}$, or summation of n numbers divided by n

$$
   \begin{aligned}
   \dot{x} & = \sigma(y = x) \\
   \dot{y} & = \rho x - y - xz \\
   \dot{z} & = ~\beta z + xy \\
   \end{aligned}
$$

Next Slide
========================================================

First column
***

Second Column

