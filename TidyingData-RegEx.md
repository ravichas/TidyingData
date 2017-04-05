BTEP-RegEx
================
Drs. Sarangan Ravichandran and Randall Johnson
February 26, 2017

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
